require_relative 'node'

# the graph of the nodes of our game
class Graph

  attr_reader :nodes

  # for now statically initialized
  # TODO: Is there any way of making this set up stuff beautiful?
  # SOLUTION? put it into a YAML file god damn it!
  def initialize
    @nodes = []
    @nodes << (video =  Node.new("Videoplatform"))
    @nodes << (social_1 = Node.new("Social 1", [video]))
    @nodes << (social_2 = Node.new("Social 2", [social_1, video]))
    @nodes << (social_3 = Node.new("Social 3", [video]))
    @nodes << (like_1 = Node.new("Like 1", [social_1]))
    @nodes << (like_2 = Node.new("Like 2", [social_3]))
    @nodes << (microblogging = Node.new("Microblogging", [social_3]))
    @nodes << (rumor_1 = Node.new("Rumor 1", [social_2, video]))
    @nodes << (rumor_2 = Node.new("Rumor 1", [social_3, microblogging]))
    @nodes << (blogging_1 = Node.new("Blogging 1", [microblogging, like_2,
                                                    social_2]))
    @nodes << (blogging_2 = Node.new("Blogging 2", [social_3, like_1, video]))
  end

  def list_nodes
    puts "There are the following nodes:"
    @nodes.each_with_index { |each, i| puts "#{i+1}: #{each.name}" }
  end

  def info_about_node(number)
    @nodes[number-1].info
  end

end

