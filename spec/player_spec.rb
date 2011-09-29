require_relative 'spec_helper'

describe "Player" do

  before :each do
    @player = Player.new("Tobi")
  end

  it "should be created with a name" do
    @player.name.should == "Tobi"
  end

  it "should have an amount of hours after creation" do
    @player.hours.should > 0
  end

  it "should have time left when created" do
    @player.out_of_time?.should be false
  end

  it "should reset the hours when a new turn is initiated" do
    @player.hours = 0

    @player.new_turn

    @player.hours.should > 0
  end


end

