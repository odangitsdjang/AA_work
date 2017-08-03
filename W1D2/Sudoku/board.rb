require_relative 'tile.rb'
require_relative 'game.rb'
require 'byebug'

class Board
  attr_accessor :grid

  def initialize(grid = Array.new(9) { Array.new(9) {Tile.new}})
    @grid = grid
    @grid.each do |row|
      row.each do |el|
        el.value == 0 ? el.value = nil : el
      end
    end
  end

  def update_location(position, val)
    @grid[position[0]][position[1]].value = val
  end

  def solved?
    byebug
    @grid.all? { |row| row.all? { |el| !el.value.nil? } }
  end

  def self.from_file(txt_name)
    file_grid =  Array.new(9) { Array.new(9) {Tile.new}}
    File.readlines(txt_name).each_with_index do |line, idx|
      file_grid[idx] = line.chomp.chars.map(&:to_i).map! do |el|
          Tile.new(el)
      end
    end
    Board.new(file_grid)

  end


  def render
    str = "Board state: \n"
    @grid.each_with_index do |row, row_indx|
      row.each_with_index do |el, c_indx|
        if @grid[row_indx][c_indx].value.nil?
          str += "* "
        else

          str += "#{el.value} "
        end
      end
      str+= "\n"
    end
    puts str
  end


end
