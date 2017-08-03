require_relative 'game.rb'
require_relative 'card.rb'
require_relative 'player.rb'
require 'byebug'

class Board

  attr_accessor :grid

  def initialize(size=4)
    @grid = Array.new(size) { Array.new(size) }
    self.populate
  end

  def populate
    card_arr = []
    (8).times do |indx|
      2.times do
        card_arr << Card.new(indx)
      end
    end
    card_arr.shuffle!

    @grid.each_with_index do |row, row_index|
      row.each_index do |col_indx|
        @grid[row_index][col_indx] = card_arr.pop
      end
    end

  end

  def render
    output = ""
    @grid.each do |row|
      row.each do |el|
        el.side == 'u' ? output += "#{el.value} " : output += "* "
      end
      output += "\n"
    end
    puts output
  end

  def won?
    @grid.all? { |row| row.all? { |el| el.side == 'u' } }
  end

  def reveal(guessed_pos)
    row = guessed_pos[0]
    col = guessed_pos[1]
    @grid[row][col].side = 'u' if @grid[row][col].side == 'd'
    @grid[row][col].value
  end

end
