require_relative 'spec_helper'

ANTI_AGILE_RUMOR = <<-eos
                   Change is never going to happen! You can specify
                   all the requirements up front. Nothing is ever going to
                   change!
                   eos

describe "Rumor" do

  before :each do
    @dummy_node = Node.new("dummy", nil)
  end

  it "can be created with a name" do
    rumor = Rumor.new("MyRumor", @dummy_node)

    rumor.name.should == "MyRumor"
  end

end

