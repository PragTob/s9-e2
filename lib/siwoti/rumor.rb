module Siwoti
  class Rumor

    BASE_CONTAMINATION = 5
    VARYING_CONTAMINATION = 20
    CONTAMINATION_PER_ROUND = 10
    CONTAMINATION_TO_SPREAD = 20
    SPREAD_REDUCE_VALUE = 4
    TOO_SMALL_CONTENT_VALUE = 2

    attr_reader :name, :infected_nodes
    attr_accessor :discovered, :knowledge

    def initialize(name, node)
      @name = name
      @infected_nodes = []
      node.rumors[self] = BASE_CONTAMINATION + rand(VARYING_CONTAMINATION)
      @infected_nodes << node

      # the knowledge the group gathered about this rumor
      @knowledge = 0

      # rumors start out undiscovered
      @discovered = false
    end

    def increase_contamination
      @infected_nodes.each do |node|
        node.rumors[self] += rand(CONTAMINATION_PER_ROUND)
        node.rumors[self] = 100 if node.rumors[self] > 100
        spreading_value = rand(node.rumors[self])
        if spreading_value > CONTAMINATION_TO_SPREAD
          spread_from(node, spreading_value)
        end
      end
    end

    def decrease_contamination(value, node)
      if value >= node.rumors[self]
        node.rumors.delete(self)
        @infected_nodes.delete(node)
      else
        node.rumors[self] -= value
      end

      # decrease the contamination in adjacent nodes (to a lesser degree)
      # yes this will again reduce the value in the original node
      value /= SPREAD_REDUCE_VALUE
      if value >= CONTAMINATION_TO_SPREAD
        node.adjacent_nodes.each do |node|
          decrease_contamination(value, node) if node.rumors[self]
        end
      end
    end

    def extinct?
      @infected_nodes.empty?
    end

    private

    def spread_from(node, spreading_value)
      uninfected = node.adjacent_nodes.reject { |node| node.rumors[self] }
      unless uninfected.empty?
        node_to_infect = uninfected.sample
        node_to_infect.rumors[self] = spreading_value
        @infected_nodes << node_to_infect
      end
    end

  end
end

