class Rumor

  attr_reader :name, :description

  def initialize(name, description=nil)
    @name = name
    @description = description
  end

end

