module Siwoti
  module Game
    extend self

    RUMOR_PER_PLAYER_FACTOR = 3
    NEW_RUMOR_CHANCE = 0.2

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
      View.hours_left(current_player)
      case action
      when /v/
        View.display_graph(graph)
      when /r/
        research
      when /s/
        View.hours_to_search(graph)
      # FIXME: development shortcut
      when /e/
        research_rumor(nil, 8)
      else
        puts "Command not recognized/implemented"
      end
    end

    def research
      if discovered_rumors.empty?
        View.nothing_to_research
      else
        View.select_rumor_to_research(discovered_rumors)
      end
    end

    def research_rumor(rumor, hours)
      if hours > current_player.hours
        View.no_time_left
      else
        current_player.research(rumor, hours)
      end
    end

    def main_loop
      until game_over?
        until round_over?
          until current_player.out_of_time?
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
      increase_rumor_contamination
      @rumors.each { |rumor| View.display_rumor(rumor) }
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
        new_rumor
      end
    end

    def new_rumor
      @rumors << Rumor.new("Rumor #{@rumors.size + 1}", graph.nodes.sample)
    end

    def increase_rumor_contamination
      @rumors.each { |rumor| rumor.increase_contamination }
      if rand < (NEW_RUMOR_CHANCE * players.size)
        new_rumor
      end
    end

    def discovered_rumors
      @rumors.find_all { |rumor| rumor.discovered == true }
    end

    def search_for_rumors(node, hours)
      if hours > current_player.hours
        View.no_time_left
      else
        old_rumors = discovered_rumors
        current_player.search_for_rumors(node, hours)
        new_rumors = discovered_rumors - old_rumors

        if new_rumors.empty?
          View.no_rumors_found
        else
          View.new_rumors(new_rumors)
        end
      end
    end

  end
end

