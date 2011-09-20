require_relative 'player'

class Game

  attr_reader :players, :round

  def initialize
    @players = []
    @round = 1
  end

  def add_player(name)
    @players << Player.new(name)
  end

end

