require 'byebug'

class Game

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @dictionary = get_dict
    @fragment = ""
    @current_player = player1
  end


  def get_dict
    words = []
    File.open('dictionary.txt').each { |line| words << line.chomp }
    words
  end

  def play
    until @player1.ghost_stack.length == 0 || @player2.ghost_stack.length == 0
      play_round
    end
    puts "Game Over!"
  end

  def play_round
    until round_won?
      take_turn(@current_player)
      next_player!
    end
    previous_player.ghost_stack.delete_at(0) # fix this line, move somewhere else
    puts "#{previous_player.name} lost the round."
    #byebug
  end

  def round_won?
    @dictionary.include?(@fragment)
  end

  def current_player
    @current_player
  end

  def previous_player
    if @current_player == @player1
      @player2
    else
      @player1
    end
  end

  def next_player!
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end

  def take_turn(player)
    puts "Current fragment is #{@fragment}"
    puts "It is now #{@current_player.name}'s turn."
    until valid_play?(y=player.guess)
      player.alert_invalid_guess
    end
    @fragment += y
  end

  # Checks that string is a letter of the alphabet and that there are words we can spell
  # after adding it to the fragment.
  def valid_play?(string)
    play_string = @fragment + string
    p "Play string is: #{play_string}"
    @dictionary.any? do |word|
      word[0..play_string.length].include?(play_string) # double check
    end
  end
end


class Player
  attr_reader :name
  attr_accessor :ghost_stack

  def initialize(name)
    @name = name
    @ghost_stack = ["G", "H", "O", "S", "T"]
  end

  def guess
    puts "Please guess a valid alphabet!"
    @input = gets.chomp

  end

  def alert_invalid_guess
    puts "Guess again!"
  end
end

if  __FILE__ == $PROGRAM_NAME
  game = Game.new(Player.new('David'), Player.new('Rachel'))
  game.play

end
