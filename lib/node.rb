module Siwoti
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

  end
end

