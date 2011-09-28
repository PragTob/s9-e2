module Siwoti
  module View
    extend self

    def greet_players
      puts "Welcome to Someone is wrong on the Internet (siwoti)"
      puts "How many players will join this game?"

      Game.introduce_players(gets.chomp.to_i)
    end

    def welcome_player(name)
      puts "Hello #{name}, nice to have you on board!"
      puts "I hope you enjoy this game!\n"
    end

    def newline
      puts
    end

    def new_player(number)
      puts "Hey player #{number}! What's your name?"
      Game.add_player(gets.chomp)
    end

    def next_round(round)
      puts "\n------END OF ROUND #{round}------\n"
    end

    # TODO display_nodes/display_graph/display_node
    # I smell some big refactoring possibilities here
    def display_nodes(nodes)
      nodes.to_a.each_with_index { |each, i| puts "#{i+1}: #{each.name}" }
      newline
    end

    def display_graph(graph)
      puts "There are the following nodes:"
      display_nodes(graph.nodes)

      puts "Do you want more information about a specific node?"
      puts "If so, type a number, otherwise type anything except for a number."
      action = gets.chomp

      case action
      when /\d+/
        display_node(graph.nodes[action.to_i - 1], graph)
      else
        # get back to main loop
      end
    end

    def display_node(node, graph)
      puts node.name
      if graph.adjacents[node].empty?
        puts "No adjacent nodes!"
      else
        puts "Adjacent nodes are:"
        display_nodes(graph.adjacents[node])

        newline
        puts "Do you want any further information about a node?"
        puts "If so type its number, otherwise type anything else:"

        action = gets.chomp

        case action
        when /\d+/
          display_node(adjacents[action.to_i - 1], graph)
        else
          # back to the main loop
        end
      end
    end

    def choose_action(current_player, round)
      puts current_player.to_s + " it's your turn! We are in round #{round}"
      hours_left(current_player)
      puts "What do you want to do?"
      puts "[c]reate content disproving a rumor?"
      puts "[r]esearch information on a rumor?"
      puts "[s]earch for new rumors on the Internet?"
      puts "[d]isplay information about the currently known rumors?"
      puts "[v]iew the graph?"
      Game.execute_action(gets.chomp)
    end

    def nothing_to_research
      puts "You haven't discovered any rumors you could do research on yet!\n"
    end

    def select_rumor_to_research(rumors)
      puts "Which rumor do you want to do research on?"

      rumors.each_with_index { |rumor, i| puts "#{i + 1}. #{rumor.name}" }
      puts "Press the according number."
      rumor = rumors[gets.chomp.to_i - 1]

      puts "How many hours do you want to spend research this rumor?"
      hours = gets.chomp.to_i

      Game.research_rumor(rumor, hours)
    end

    def research_increased(rumor, hours)
      puts "You spend #{hours} hours researching rumor #{rumor.name}"
      puts "Your knowledge of this rumor increased to #{rumor.knowledge}\n\n"
    end

    def no_time_left
      puts "You don't have that much time left this round!\n"
    end

    def hours_left(current_player)
      puts "Hey #{current_player.name}, you currently have"
        + "#{current_player.hours} hours left."
    end

    def hours_to_search(graph)
      puts "At which node do you want to search for a new rumors?"
      display_nodes(graph.nodes)

      puts "Type the number of the node you want to search for new rumors."
      node = graph.nodes[gets.chomp.to_i - 1]

      puts "How many hours do you want to spend searching for new rumors?"
      hours = gets.chomp.to_i
      newline

      Game.search_for_rumors(node, hours)
    end

    def new_rumors(rumors)
      puts "Congratulation you have discovered new rumors!"
      rumors.each do |rumor|
        puts "You have discovered the rumor #{rumor.name}"
        puts "The infected nodes are:"
        display_nodes(rumor.infected_nodes)
      end
    end

    def no_rumors_found
      puts "Oh bad luck, you didn't discover any new rumors!"
    end

    def discovered_rumors(rumors)
      if rumors.empty?
        puts "Sorry you haven't discovered any rumor yet!"
        puts "Try searching for rumors.\n\n"
      else
        puts "You have already discovered the following rumors:"
        rumors.each_with_index { |rumor, i| display_rumor(rumor, i) }
      end
    end

    def display_rumor(rumor, i)
      puts "#{i +1}. Rumor: #{rumor.name}"
      puts "  Your knowledge level of this rumor is: #{rumor.knowledge}"
      puts "  The infected nodes are:"
      rumor.infected_nodes.each do |node|
        puts "  #{node.name}  with #{node.rumors[rumor]}%"
      end
      newline
    end

    def create_content(rumors)
      puts "You know the following rumors:"
      discovered_rumors

      puts "Which rumor do you want to disprove? (Type the number)"
      rumor = rumors[gets.chomp.to_i -1]

      puts "How many hours do you want to spend on creating content " +
        "disproving this rumor?"
      hours = gets.chomp.to_i

    end

  end
end

