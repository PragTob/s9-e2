module Siwoti
  module View
    extend self

    def greet_players
      puts "Welcome to Someone is wrong on the Internet (siwoti)"
      puts "How many players will join this game?"

      Game.introduce_players(gets.chomp.to_i)
    end

    def new_player(number)
      puts "Hey player #{number}! What's your name?"
      Game.add_player(gets.chomp)
    end

    def next_round(round)
      puts "------END OF ROUND #{round}------"
    end

    def display_graph(graph)
      puts "There are the following nodes:"
      graph.nodes.each_with_index { |each, i| puts "#{i+1}: #{each.name}" }

      puts "Do you want more information about a specific node?"
      puts "If so, type a number, otherwise type anything except for a number."
      action = gets.chomp

      case action
      when /\d+/
        display_node(graph.nodes[action.to_i - 1])
      else
        # get back to main loop
      end
    end

    def display_node(node)
      puts node.name
      if node.adjacent_nodes.empty?
        puts "No adjacent nodes!"
      else
        puts "Adjacent nodes are:"

        node.adjacent_nodes.each_with_index do |each, i|
          puts "#{i+1}: #{each.name}"
        end

        puts "Do you want any further information about a node?"
        puts "If so type its number, otherwise type anything else:"
        action = gets.chomp

        case action
        when /\d+/
          display_node(node.adjacent_nodes[action.to_i - 1])
        else
          # return somehow
        end
      end
    end

    def choose_action(current_player, round)
      puts current_player.to_s + " it's your turn! We are in round #{round}"
      puts "you have got #{current_player.hours} hours left"
      puts "What do you want to do?"
      puts "[c]reate content disproving a rumor?"
      puts "[r]esearch information on a rumor?"
      puts "[s]earch for new rumors on the Internet?"
      puts "[d]isplay information about the currently known rumors?"
      puts "[v]iew the graph?"
      Game.execute_action(gets.chomp)
    end

  end
end

