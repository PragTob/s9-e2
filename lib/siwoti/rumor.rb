module Siwoti
  class Rumor

    BASE_CONTAMINATION = 5
    VARYING_CONTAMINATION = 20
    CONTAMINATION_PER_ROUND = 10
    CONTAMINATION_TO_SPREAD = 20

    attr_reader :name, :infected_nodes
    attr_accessor :discovered

    def initialize(name, node)
      @name = name
      @infected_nodes = []
      node.rumors[self] = BASE_CONTAMINATION + rand(VARYING_CONTAMINATION)
      @infected_nodes << node

      # rumors start out undiscovered
      @discovered = false
    end

    def increase_contamination
      @infected_nodes.each do |node|
        node.rumors[self] += rand(CONTAMINATION_PER_ROUND)
        spreading_value = rand(node.rumors[self])
        if spreading_value > CONTAMINATION_TO_SPREAD
          spread_from(node, spreading_value)
        end
      end
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

