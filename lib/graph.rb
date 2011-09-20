require_relative 'node'

# the graph of the nodes of our game
class Graph

  # for now statically initialized
  # TODO: Is there any way of making this set up stuff beautiful?
  def initialize
    nodes = []
    video =  Node.new("Videoplatform")
    social_1 = Node.new("Social 1", [video])
    social_2 = Node.new("Social 2", [social_1, video])
    social_3 = Node.new("Social 3", [video])
    like_1 = Node.new("Like 1", [social_1])
    like_2 = Node.new("Like 2", [social_3])
    microblogging = Node.new("Microblogging", [social_3])
    rumor_1 = Node.new("Rumor 1", [social_2, video])
    rumor_2 = Node.new("Rumor 1", [social_3, microblogging])
    blogging_1 = Node.new("Blogging 1", [microblogging, like_2, social_2])
    blogging_2 = Node.new("Blogging 2", [social_3, like_1, video])
  end

end

