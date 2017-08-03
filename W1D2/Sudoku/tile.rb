require_relative 'board.rb'
require_relative 'game.rb'

class Tile
  attr_accessor :value

  def initialize(value=nil)
    @value = value
  end

end
