module Siwoti
  class Player

    HOURS_PER_TURN = 8
    RUMOR_SEARCH_FACTOR = 3 # higher makes it more difficult
    RESEARCH_PER_HOUR_BASE = 3
    RESEARCH_PER_HOUR = 5
    CONTENT_PER_HOUR_MODIFIER = 0.5

    attr_reader :name
    attr_accessor :hours

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
      discover_rumors(node, search_value)
    end

    def discover_rumors(node, search_value)
      discovered_rumors = []

      # now you get a chance to discover every rumor
      node.rumors.each do |rumor, contamination|
        if search_value <= contamination &&  !rumor.discovered
          rumor.discovered = true
          discovered_rumors << rumor
        end
      end
      discovered_rumors
    end

    def create_content(rumor, hours)
      @hours -= hours
      rumor.knowledge * hours * CONTENT_PER_HOUR_MODIFIER
    end

  end
end

