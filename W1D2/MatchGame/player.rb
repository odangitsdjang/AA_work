require_relative 'board.rb'
require_relative 'game.rb'
require_relative 'card.rb'

class HumanPlayer

  attr_reader :name
  attr_accessor :grid

  def initialize(name)
    @name = name
    @grid = []
  end

  def prompt
    puts "Hey #{@name}, enter the row (1-4): "
    row = gets.chomp.to_i
    puts "Now enter the column (1-4): "
    column = gets.chomp.to_i
    [row, column]
  end

  def store_best_match
    #not doing anything
  end

end


class ComputerPlayer

  attr_reader :name
  attr_accessor :grid, :match

  def initialize(name)
    @name = name
    @grid = []
  end

  def prompt
    @match.shift
  end

  def store_best_match
    freqs = Hash.new(0)
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |el, col_index|
        if !el.nil?
          freqs[el.value] += 1 if el.side == 'u'
        end
      end
    end

    value = freqs.select { |k,v| v == 2 }.keys.first

    coords = []

    if value
      @grid.each_with_index do |row, row_index|
        row.each_with_index do |el, col_index|
          if !el.nil?
            if @grid[row_index][col_index].value == value
              coords.push([row_index,col_index])
            end
          end
        end
      end
    else
      @grid.each_with_index do |row, row_index|
        row.each_with_index do |el, col_index|
          if !el.nil?
            if @grid[row_index][col_index].side == 'd'
              coords.push([row_index,col_index])
            end
          end
        end
        coords = coords[0..1]
      end
    end
    @match = coords
  end

end
