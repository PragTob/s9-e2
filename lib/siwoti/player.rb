module Siwoti
  class Player

    HOURS_PER_TURN = 8
    RUMOR_SEARCH_FACTOR = 4
    RESEARCH_PER_HOUR_BASE = 3
    RESEARCH_PER_HOUR = 5

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

    def research(rumor, time)
      @hours -= time
      knowledge = (RESEARCH_PER_HOUR_BASE + rand(RESEARCH_PER_HOUR))  * time
      rumor.knowledge += knowledge
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

