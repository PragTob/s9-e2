module Siwoti
  class Node

    attr_reader :name

    # rumors is a hash pointing from a rumor to the % this node believes in it
    attr_reader :rumors

    # we have the graph so we can check for our adjacent nodes
    def initialize(name, graph)
      @name = name
      @graph = graph
      @rumors = {}
    end

    def adjacent_nodes
      @graph.adjacents[self]
    end

  end
end

