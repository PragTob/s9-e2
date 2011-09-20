class Player

  HOURS_PER_TURN = 8

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

  def research
  end

  def search_for_rumor
  end

end

