require_relative '../lib/player'

describe "Player" do

  it "should be created with a name" do
    player = Player.new "Tobi"
    player.name.should == "Tobi"
  end

end

