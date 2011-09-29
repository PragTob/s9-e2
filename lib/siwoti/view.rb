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
      puts "I hope you enjoy this game!"
      newline
    end

    # puts needs \n\n at the end, looks kind of ugly
    def newline
      puts
    end

    def new_player(number)
      puts "Hey player #{number}! What's your name?"
      puts "(Just hit Enter and I'll give you a name - whether you like it" +
        " or not.)"
      Game.add_player(gets.chomp)
    end

    def difficulty
      puts "How difficult shall this game be?"
      puts "[e]asy - disprove one rumor to win the game."
      puts "everything else results in the default value" +
        "(#{Game::DEFAULT_ELIMINATED_RUMORS_TO_WIN})"
      Game.difficulty(gets.chomp)
    end

    def initial_rumor(rumor)
      puts "Today you were surfing on the internet... nothing special."
      puts "But then you stumble upon something..."
      puts "A rumor claiming #{rumor.name}!"
      puts "This is outrageous!!!"
      puts "You embark on a journey to disprove this rumor and all other " +
        "rumors you come across!"
      puts "You have discovered this rumor, but be aware there are many " +
        "undiscovered rumors out there."
      puts "Disprove #{Game.eliminated_rumors_to_win} in order to win."
      puts "But if more than #{Game::LOOSE_PERCENT}% of the people on all " +
        "nodes believe in a rumor, you lose!"
      puts "Good luck - you will need it!"
      newline
    end

    def next_round(round)
      puts "\n------END OF ROUND #{round}------"
      newline
    end

    def display_nodes(nodes)
      nodes.to_a.each_with_index { |each, i| puts "#{i+1}: #{each.name}" }
      newline
    end

    def display_graph(graph)
      puts "There are the following nodes:"
      display_nodes(graph.nodes)
      explore_nodes(graph.nodes)
    end

    def display_node(node)
      puts node.name
      adjacent_nodes = node.adjacent_nodes.to_a
      if adjacent_nodes.empty?
        puts "No adjacent nodes!"
      else
        puts "Adjacent nodes are:"
        display_nodes(adjacent_nodes)
        explore_nodes(adjacent_nodes)
      end
    end

    def explore_nodes(nodes)
      puts "Do you want more information about a specific node?"
      puts "If so, type a number, otherwise type anything except for a number."
      action = gets.chomp

      case action
      when /\d+/
        number = action.to_i
        if (1..nodes.size).include?(number)
          display_node(nodes[number - 1])
        else
          display_node(get_element_from(nodes))
        end
      else
        # get back to main loop
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
      puts "[e]nd this turn now? (in order to lose fast)"
      Game.execute_action(gets.chomp)
    end

    def nothing_to_research
      puts "You haven't discovered any rumors you could do research on yet!\n"
    end

    def select_rumor_to_research(rumors)
      puts "Which rumor do you want to do research on?"

      rumors.each_with_index { |rumor, i| puts "#{i + 1}. #{rumor.name}" }
      puts "Press the according number."
      rumor = get_element_from(rumors)

      puts "How many hours do you want to spend research this rumor?"
      hours = gets.chomp.to_i

      Game.research_rumor(rumor, hours)
    end

    def research_increased(rumor, hours)
      puts "You spend #{hours} hours researching rumor #{rumor.name}"
      puts "Your knowledge of this rumor increased to #{rumor.knowledge}"
      newline
    end

    def no_time_left
      puts "You don't have that much time left this round!"
      newline
    end

    def hours_left(current_player)
      puts "Hey #{current_player.name}, you currently have " +
        "#{current_player.hours} hours left."
    end

    def search(graph)
      puts "At which node do you want to search for a new rumors?"
      puts "Hint: you will also search in its adjacent nodes"
      display_nodes(graph.nodes)

      puts "Especially at the beginning of the game rumors are hard to discover"
      puts "Type the number of the node you want to search for new rumors."
      node = get_element_from(graph.nodes)

      puts "How many hours do you want to spend searching for new rumors?"
      hours = gets.chomp.to_i
      newline

      Game.search_for_rumors(node, hours)
    end

    def new_rumors(rumors)
      puts "Congratulation you have discovered new rumors!"
      puts "Following is a list of the found rumors and the infected nodes:"
      display_rumors(rumors)
    end

    def no_rumors_found
      puts "Oh bad luck, you didn't discover any new rumors!"
    end

    def discovered_rumors(rumors)
      if rumors.empty?
        puts "Sorry you haven't discovered any rumor yet!"
        puts "Try searching for rumors."
        newline
      else
        puts "You have already discovered the following rumors:"
        display_rumors(rumors)
      end
    end

    def display_rumors(rumors)
      rumors.each_with_index { |rumor, i| display_rumor(rumor, i) }
      newline
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
      if rumors.empty?
        puts "You don't know any rumors yet, try to search for them."
      else
        puts "You know the following rumors:"
        discovered_rumors(rumors)

        puts "Which rumor do you want to disprove? (Type the number)"
        rumor = get_element_from(rumors)

        puts "Please choose the node you want to post the content to."
        puts "Note that this also partially disproves rumors in adjacent nodes."
        newline
        display_nodes(rumor.infected_nodes)
        puts "Choose the node by typing in its number."
        node = get_element_from(rumor.infected_nodes)

        puts "How many hours do you want to spend on creating content " +
          "disproving this rumor?"
        hours = gets.chomp.to_i

        Game.create_content(rumor, node, hours)
      end
    end

    def get_element_from(elements)
      range = 1..elements.size
      begin
        puts "Put in a number in the range #{range}"
        number = gets.chomp.to_i
      end until range.include?(number)
      elements[number - 1]
    end

    def succesful_content_creation
      puts "You succesfully created content."
      puts "Check out your known information about rumors if you want to know" +
        " what the effect was."
      newline
    end

    def failed_content_creation
      puts "The content you produced wasn't of a high enough quality."
      puts "The people didn't really even take notice and continued to " +
        "believe in the rumor."
      newline
    end

    def game_won
      puts "Congratulations, you have won an epic game of someone is wrong on" +
        " the Internet!"
      puts "You're awesome!"
    end

    def game_lost
      puts "You could not right all wrongs and now everybody believes in a " +
        "stupid rumor..."
      puts "Try harder next time!"
    end

    def eliminated_rumor(count)
      puts "You succesfully eliminated a rumor! Congrats!"
      puts "You have now eliminated #{count} rumors."
      puts "You need to eliminate #{Game::DEFAULT_ELIMINATED_RUMORS_TO_WIN} " +
        "rumors in order to win the game."
    end

    def new_rumor
      puts "There is an uproar on the Internet..."
      puts "It seems like a new rumor just has spread,"
      newline
    end

    def command_not_recognized(command)
      puts "The command you just put in was not recognized."
      puts "The command was #{command}."
      puts "Please try again."
      newline
    end

    def no_negative_time
      puts "Hey you can't do something in negative or no time."
    end

  end
end

