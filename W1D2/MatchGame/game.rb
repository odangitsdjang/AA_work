require_relative 'card.rb'
require_relative 'board.rb'
require_relative 'player.rb'
require 'byebug'



class Game

  attr_accessor :board, :guess

  def initialize(player1)
    @player = player1
    @board = Board.new
    #@player.grid = @board.grid.dup
    @board.grid.each_with_index do |row, row_index|
      @player.grid.push([])
      row.each_with_index do |el, col_index|
        @player.grid[row_index].push(el.dup)
      end
    end
  end

  def play
    puts "Game starting: "
    until @board.won?
      play_turn
    end
    puts "Game over!"
  end

  def save_to_computer(coordinates)
    @player.grid[coordinates[0]][coordinates[1]].side = 'u'
  end


  def play_turn
    @guess = []
    @vals = []
    puts "New round: "

    @player.store_best_match

    2.times do |indx|
      @board.render

      valid = false
      until valid
        row, col = @player.prompt
        side = @board.grid[row][col].side
        if side == 'd'
          @guess << [row,col]
          valid = true
        else
          puts "Card already face up. Try again!"
        end
      end
      @vals << @board.reveal(@guess[indx])
      save_to_computer(@guess[indx])
    end

    @board.render

    @guess.each do |guess_coord|
      if @vals[0] != @vals[1]
        @board.grid[guess_coord[0]][guess_coord[1]].side = 'd'  # double check
        puts "Didn't match! Try again"
      else
        @player.grid[guess_coord[0]][guess_coord[1]] = nil
      end
    end

  end

end


if __FILE__ == $PROGRAM_NAME
  game = Game.new(ComputerPlayer.new("Mr.Whatevs"))
  game.play
end
