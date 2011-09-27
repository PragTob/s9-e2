module Siwoti
  class Rumor

    BASE_PENETRATION = 5
    VARYING_PENETRATION = 20

    attr_reader :name, :description
    attr_accessor :discovered

    def initialize(name, node, description=nil)
      @name = name
      @description = description
      @infected_nodes = []
      node.rumors[self] = BASE_PENETRATION + rand(VARYING_PENETRATION)
      @infected_nodes << node

      # rumors start out undiscovered
      @discovered = false
    end

  end
end

