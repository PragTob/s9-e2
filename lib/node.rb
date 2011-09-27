module Siwoti
  class Node

    attr_reader :name

    # rumors is a hash pointing from a rumor to the % this node believes in it
    attr_reader :rumors

    def initialize(name)
      @name = name
      @rumors = {}
    end

  end
end

