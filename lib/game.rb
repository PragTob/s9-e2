require_relative 'player'

class Game

  class << self
    attr_reader :players
    attr_reader :round
  end

  @players = []
  @round = 1

  def self.add_player(name)
    @players << Player.new(name)
  end

end

