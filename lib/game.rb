module Siwoti
  class Game

    attr_reader :players, :round, :graph

    def initialize
      @players = []
      @round = 0
      @graph = Graph.new
      @current_player_number = 0
    end

    def initialize_players
      puts "Welcome to Someone is wrong on the Internet (siwoti)"
      puts "How many players will join this game?"
      number_of_players = gets.chomp.to_i

      number_of_players.times do |i|
        puts "Hey player #{i+1}! What's your name?"
        add_player(gets.chomp)
      end

    end

    def add_player(name)
      @players << Player.new(name)
    end

    def display_action_chooser_text
      puts current_player.to_s + " it's your turn! We are in round #{round}"
      puts "you have got #{current_player.hours} hours left"
      puts "What do you want to do?"
      puts "[c]reate content disproving a rumor?"
      puts "[r]esearch information on a rumor?"
      puts "[s]earch for new rumors on the Internet?"
      puts "[d]isplay information about the currently known rumors?"
      puts "[v]iew the graph?"
    end

    def execute_action(action)
      case action
      when /v/
        view_graph
      when /r/
        current_player.research
      else
        puts "Command not recognized/implemented"
      end
    end

    def choose_action
      display_action_chooser_text
      action = gets.chomp
      execute_action(action)
    end

    def main_loop
      until game_over?
        until round_over?
          until current_player.no_hours_left?
            choose_action
          end
          next_player
        end
        next_round
      end
    end

    def next_round
      puts "------END OF ROUND #{round}------"
      @round += 1
      @current_player_number = 0
      @players.each { |player| player.new_turn }
      main_loop
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

    # no winning condition (yet) :P You all los!
    def game_over?
      false
    end

    def view_graph
      graph.view
    end

  end
end

