require_relative 'game.rb'
require_relative 'board.rb'
require_relative 'player.rb'


class Card

  attr_reader :value
  attr_accessor :side

  def initialize(value)
    @value = value
    @side = 'd'
  end

  def hide
    @side = 'd'
  end

  def reveal
    @side = 'u'
  end

  def ==(card)
    @value == card.value
  end

end
