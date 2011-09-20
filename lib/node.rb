# a node in the graph

class Node

  attr_reader :name

  # rumors is a hash pointing from a rumor to the % this node believes in it
  attr_reader :rumors
  attr_accessor :adjacent_nodes

  def initialize(name, adjacent_nodes=[])
    @name = name
    @adjacent_nodes = []
    adjacent_nodes.each { |node| add_adjacent_node(node) }
    @rumors = {}
  end

  def add_adjacent_node(node)
    adjacent_nodes << node
    node.adjacent_nodes << self
  end

  def info
    puts self.name
    if adjacent_nodes.empty?
      puts "No adjacent nodes!"
    else
      puts "Adjacent nodes are:"
      adjacent_nodes.each_with_index { |each, i| puts "#{i+1}: #{each.name}" }

      puts "Do you want any further information about a node?"
      puts "If so type its number, otherwise type anything else:"
      action = gets.chomp

      case action
      when /\d+/
        adjacent_nodes[action.to_i - 1].info
      else
        # return somehow
      end

    end
  end

end

