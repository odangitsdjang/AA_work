require_relative 'tile.rb'
require_relative 'board.rb'

class Game

  attr_accessor :board

  def initialize(board)
    @board = board
  end


  def play
    until @board.solved?
      play_turn
    end
    puts "Game over!"
  end


  def play_turn
    @board.render
    puts "Enter row (0-8):"
    row = gets.chomp.to_i
    puts "Enter column (0-8):"
    column = gets.chomp.to_i
    puts "Finally, enter a value that you think is correct for (#{row}, #{column}):"
    value = gets.chomp.to_i
    @board.update_location([row, column], value)
  end
end



if __FILE__ == $PROGRAM_NAME
  game = Game.new(Board::from_file('puzzles/sudoku1.txt'))
  game.play
end
