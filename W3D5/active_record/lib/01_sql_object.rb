require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  @table_name = nil
  @columns = nil
  def self.columns
    if @columns.nil?
      query_result = DBConnection.execute2(<<-SQL)
                    SELECT * FROM #{self.table_name}
                    SQL
      @columns = query_result.first.map(&:to_sym)
    else
      @columns
    end
  end

  def self.finalize!
    self.columns.each do |col_symbol|
      define_method(col_symbol) do
        self.attributes[col_symbol]
      end

      define_method("#{col_symbol}=") do |value|
        self.attributes[col_symbol] = value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name.nil? ? (self.to_s).tableize : @table_name
  end

  def self.all
    query_result = DBConnection.execute(<<-SQL)
                  SELECT #{self.table_name}.* FROM #{self.table_name}
                  SQL
    arr = []
    query_result.each_with_index do |hash, i|
      tmp = {}
      hash.each do |k,v|
        tmp[k] = v
      end
      arr << tmp
    end
    self.parse_all(arr)
  end

  def self.parse_all(results)
    results.map {|hash| self.new(hash)}
  end

  def self.find(id)
    self.all.find { |obj| obj.id == id }
  end

  def initialize(params = {})
    params.each do |attr_name, value|
       attr_name = attr_name.to_sym
       if self.class.columns.include?(attr_name)
         self.send("#{attr_name}=", value)
       else
         raise "unknown attribute '#{attr_name}'"
       end
     end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
     self.class.columns.map { |attr| self.send(attr) }
  end

  def insert
    # dont include the first column because that is the id column
    col_names = self.class.columns[1..-1].map(&:to_s).join(', ')
    question_marks = (["?"] * (self.class.columns.length-1)).join(', ')
    DBConnection.execute(<<-SQL, *attribute_values[1..-1])
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update
    # dont include the first column because that is the id column
    setting = self.class.columns[1..-1]
              .map { |col| "#{col} = ?" }.join(', ')

    DBConnection.execute(<<-SQL, *attribute_values[1..-1])
      UPDATE
        #{self.class.table_name}
      SET
        #{setting}
      WHERE
        id = #{self.id}
    SQL
  end

  def save
    self.id.nil? ? insert : update
  end
end
