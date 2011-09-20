require_relative '../lib/node'

describe "Node" do

  before :each do
    @node = Node.new("Hello Node")
  end

  it "can be created with a name" do
    @node.should_not be nil
  end

  it "should not have adjacent nodes when created with just a name" do
    @node.adjacent_nodes.empty?.should == true
  end

  it "may have other nodes added" do
    other_node = Node.new("I am something else")
    @node.add_adjacent_node other_node

    @node.adjacent_nodes.empty?.should == false
    @node.adjacent_nodes.first.should eq other_node
  end

  it "should add itself to the adjacent nodes list of the adjacent node" do
    other_node = Node.new("I got no neighbours :-(")
    @node.add_adjacent_node(other_node)

    other_node.adjacent_nodes.empty?.should == false
    other_node.adjacent_nodes.first.should eq @node
  end

  it "may be created with an adjacent node given" do
    other_node = Node.new("Look I got neighbours! :-)", [@node])

    other_node.adjacent_nodes.empty?.should == false
    other_node.adjacent_nodes.first.should eq @node
  end

  it "may be created with multiple adjacent nodes given" do
    mini_node = Node.new("I am small")

    friendly_node = Node.new("I got lots of friends!", [@node, mini_node])
    friendly_node.adjacent_nodes.should == [@node, mini_node]
  end

end

