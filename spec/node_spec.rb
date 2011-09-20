require_relative '../lib/node'

# TODO I am creating too many objects, may be I should use factory_girl

def node_has_adjacent_node(node, adjacent_node)
  node.adjacent_nodes.empty?.should == false
  node.adjacent_nodes.first.should eq adjacent_node
end

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

    node_has_adjacent_node(@node, other_node)
  end

  it "should add itself to the adjacent nodes list of the adjacent node" do
    other_node = Node.new("I got no neighbours :-(")
    @node.add_adjacent_node(other_node)

    node_has_adjacent_node(other_node, @node)
  end

  it "may be created with an adjacent node given" do
    other_node = Node.new("Look I got neighbours! :-)", [@node])

    node_has_adjacent_node(other_node, @node)
  end

  it "may be created with multiple adjacent nodes given" do
    mini_node = Node.new("I am small")

    friendly_node = Node.new("I got lots of friends!", [@node, mini_node])
    friendly_node.adjacent_nodes.should == [@node, mini_node]
  end

  it "adds itself as an adjacent to a node given in the constructor" do
    other_node = Node.new("Hello", [@node])

    node_has_adjacent_node(@node, other_node)
  end

  it "adds itself as an adjacent node to all nodes given in the constructore" do
    mini_node = Node.new("mini")
    other_node = Node.new("Other", [@node, mini_node])

    node_has_adjacent_node(mini_node, other_node)
    node_has_adjacent_node(@node, other_node)
  end

end

