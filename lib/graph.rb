module Siwoti
  class Graph

    attr_reader :adjacents

    def initialize(connections)
      @adjacents = Hash.new { |hash, key| hash[key] = Set.new }

      connections.each do |node_name, neighbors|
        node = get_or_create_node(node_name)
        Array(neighbors).each do |neighbor_name|
          neighbor = get_or_create_node(neighbor_name)
          @adjacents[node].add(neighbor)
          @adjacents[neighbor].add(node)
        end
      end
    end

    def next_to(node)
      @adjacents[node].to_a
    end

    def nodes
      @adjacents.keys
    end

    def node_exists?(node_name)
      nodes.map(&:name).include?(node_name) unless nodes.empty?
    end

    def get_or_create_node(node_name)
      if node_exists?(node_name)
        node_named(node_name)
      else
        Node.new(node_name, self)
      end
    end

    def node_named(node_name)
      nodes.find { |node| node.name == node_name }
    end

    def self.default_graph
      Graph.new(
        "Videoplatform" => ["Social 1", "Social 2", "Social 3"],
        "Social 2" => "Social 1",
        "Like 1" => "Social 1",
        "Like 2" => "Social 3",
        "Microblogging" => ["Social 2", "Social 3"],
        "Rumor 1" => ["Rumor 2", "Social 2", "Videoplatform"],
        "Rumor 2" => ["Social 3", "Microblogging"],
        "Blogging 1" => ["Microblogging", "Like 2", "Social 2"],
        "Blogging 2" => ["Social 3", "Social 1", "Like 1", "Videoplatform"])
    end

  end
end

