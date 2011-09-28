module Siwoti
  class Player

    HOURS_PER_TURN = 8
    RUMOR_SEARCH_FACTOR = 4

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

    def out_of_time?
      hours <= 0
    end

    # TODO do research on the damn rumor
    def research(rumor, time)
      @hours -= hours
    end

    def search_for_rumors(node, time)
      @hours -= time
      search_value = (rand(100) * RUMOR_SEARCH_FACTOR) / time
      puts "Search value: #{search_value}"

      # now you get a chance to discover every rumor
      node.rumors.each do |rumor, contamination|
        rumor.discovered = true if search_value <= contamination
      end
    end

  end
end

