module Siwoti
  module Game
    extend self

    RUMOR_PER_PLAYER_FACTOR = 3

    attr_reader :players, :round, :graph

    def start
      @players = []
      @round = 1
      @graph = Graph.default_graph
      @current_player_number = 0
      View.greet_players
      seed_rumors
      main_loop
    end

    def introduce_players(number_of_players)
      number_of_players.times do |i|
        View.new_player(i + 1)
      end
    end

    def add_player(name)
      @players << Player.new(name)
    end

    def execute_action(action)
      case action
      when /v/
        View.display_graph(graph)
      when /r/
        current_player.research
      else
        puts "Command not recognized/implemented"
      end
    end

    def main_loop
      until game_over?
        until round_over?
          until current_player.no_hours_left?
            View.choose_action(current_player, round)
          end
          next_player
        end
        next_round
      end
    end

    def next_round
      View.next_round(round)
      @round += 1
      @current_player_number = 0
      @players.each { |player| player.new_turn }
      p @rumors
    end

    def round_over?
      @current_player_number == @players.size
    end

    def current_player
      @players[@current_player_number]
    end

    def next_player
      @current_player_number += 1
    end

    # no winning condition (yet) :P You all lose!
    def game_over?
      false
    end

    def view_graph
      View.graph(graph)
    end

    def seed_rumors
      @rumors = []
      (RUMOR_PER_PLAYER_FACTOR * players.size).times do
        @rumors << Rumor.new("Rumor #{@rumors.size + 1}", graph.nodes.sample)
      end
    end

  end
end

