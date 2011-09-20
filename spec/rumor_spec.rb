require_relative '../lib/rumor'

ANTI_AGILE_RUMOR = <<-eos
                   Change is never going to happen! You can specify
                   all the requirements up front. Nothing is ever going to
                   change!
                   eos

describe "Rumor" do

  it "can be created with a name" do
    rumor = Rumor.new "MyRumor"

    rumor.name.should == "MyRumor"
  end

  it "may also have a description" do
    rumor = Rumor.new "Agile sucks!", ANTI_AGILE_RUMOR

    rumor.description.should == ANTI_AGILE_RUMOR
  end

end

