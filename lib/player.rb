module Siwoti
  class Player

    HOURS_PER_TURN = 8
    RUMOR_SEARCH_FACTOR = 2

    attr_reader :name, :hours

    def initialize(name)
      @name = name
      @hours = HOURS_PER_TURN
    end

    def to_s
      @name
    end

    def new_turn
      @hours = HOURS_PER_TURN
    end

    def no_hours_left?
      hours <= 0
    end

    # TODO do research on the damn rumor
    def research(rumor, time)
      @hours -= hours
    end

    def search_for_rumors(node, time)
      @hours -= time
      search_value = (rand * RUMOR_SEARCH_FACTOR) / time

      # now you get a chance to discover every rumor
      node.rumors.each do |rumor, contamination|
        rumor.discovered = true if search_value <= contamination
      end
    end

  end
end

