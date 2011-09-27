module Siwoti
  class Rumor

    attr_reader :name, :description
    attr_accessor :discovered

    def initialize(name, description=nil)
      @name = name
      @description = description

      # rumors start out undiscovered
      @discovered = false
    end

  end
end

