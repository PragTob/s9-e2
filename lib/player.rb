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

  def no_hours_left?
    hours <= 0
  end

  def research
    puts "How many hours do you want to spend researching?"
    number = gets.chomp.to_i
    if number > hours
      puts "You don't have that much time left!"
    else
      @hours -= number
      puts "You have got #{hours} hours left!"
    end
  end

  def search_for_rumor
  end

end

