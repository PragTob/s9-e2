module Siwoti
  module Game
    extend self

    RUMOR_PER_PLAYER_FACTOR = 3
    NEW_RUMOR_CHANCE = 0.2
    PERSONS = ["Yoda", "Chuck Testa", "John Doe", "Matz", "Ninja", "Bill",
               "Bob Khan", "Vint Cerf", "angry cat", "Superman", "dude"]
    # Set to 1 for a really easy game
    ELIMINATED_RUMORS_TO_WIN = 4
    LOOSE_PERCENT = 80

    attr_reader :players, :round, :graph

    def start
      @players = []
      @round = 1
      @graph = Graph.default_graph
      @current_player_number = 0
      @eliminated_rumors = 0
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
      name = PERSONS.sample if name.empty?
      @players << Player.new(name)
      View.welcome_player(name)
    end

    def execute_action(action)
      View.hours_left(current_player)
      case action
      when /v/
        View.display_graph(graph)
      when /r/
        research
      when /s/
        View.search(graph)
      when /d/
        View.discovered_rumors(discovered_rumors)
      when /c/
        View.create_content(discovered_rumors)
      # TODO: development shortcut for cycling through the game fast
      when /e/
        current_player.hours -= 8
      else
        View.command_not_recognized(action)
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
      if_player_has_time(hours) do
        current_player.research(rumor, hours)
        View.research_increased(rumor, hours)
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

      # CHEAT display every rumor so you don't have to search for them
      #@rumors.each_with_index { |rumor,i| View.display_rumor(rumor,i) }
    end

    def round_over?
      @current_player_number >= @players.size
    end

    def current_player
      @players[@current_player_number]
    end

    def next_player
      @current_player_number += 1
    end

    # when is the game over? When the game is won, the game automatically exits.
    def game_over?
      if game_lost?
        View.game_lost
        true
      else
        false
      end
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
        View.new_rumor
      end
    end

    def discovered_rumors
      @rumors.find_all { |rumor| rumor.discovered == true }
    end

    def if_player_has_time(hours, &blk)
      if hours > current_player.hours
        View.no_time_left
      else
        blk.call
      end
    end

    def search_for_rumors(node, hours)
      if_player_has_time(hours) do
        new_rumors = current_player.search_for_rumors(node, hours)

        if new_rumors.empty?
          View.no_rumors_found
        else
          View.new_rumors(new_rumors)
        end
      end
    end

    def create_content(rumor, node, hours)
      if_player_has_time(hours) do
        content_value = current_player.create_content(rumor, hours)

        # initial adjustment showing that popular rumors are harder to disprove
        content_value -= node.rumors[rumor]
        if content_value > 0
          rumor.decrease_contamination(content_value, node)
          View.succesful_content_creation
          eliminate_rumor(rumor) if rumor.extinct?
        else
          View.failed_content_creation
        end
      end
    end

    def eliminate_rumor(rumor)
      @rumors.delete(rumor)
      @eliminated_rumors += 1
      if game_won?
        View.game_won
        exit
      else
        View.eliminated_rumor(@eliminated_rumors)
      end
    end

    # the game is lost when a rumor reached a contamination of over 80%
    # in every node of the graph
    def game_lost?
      @rumors.each do |rumor|
        return true if rumor.all_nodes_infected(graph.nodes, LOOSE_PERCENT)
      end
      false
    end

    def game_won?
      @eliminated_rumors >= ELIMINATED_RUMORS_TO_WIN
    end

  end
end

