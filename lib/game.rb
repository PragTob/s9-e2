require_relative 'player'
require_relative 'graph'

# kind of a facade for all the underlying stuff
class Game

  attr_reader :players, :round, :graph

  def initialize
    @players = []
    @round = 0
    @graph = Graph.new
  end

  def add_player(name)
    @players << Player.new(name)
  end

  def next_round
    @round += 1
    @current_player_number = 0
    @players.each { |player| player.new_turn }
  end

  def current_player
    @players[@current_player_number]
  end

  def next_player
    if @current_player_number <= (@players.size -2)
      @current_player_number += 1
    else
      false
    end
  end

  def turn_over?
    current_player.hours <= 0
  end

  def view_graph
    graph.list_nodes
    puts "Do you want more information about a specific node?"
    puts "If so, type a number, otherwise type anything except for a number."
    action = gets.chomp

    case action
    when /\d+/
      graph.info_about_node(action.to_i)
    else
      # get back to main loop
    end
  end

end

