Challenge Exercise: Exponential Chaos
=====================================

# State of the art

## What works?

- View the graph and inspect every node
- Rumors get seeded in the beginning, they spread randomly throughout the game and new rumors even appear
- You can search for new rumors at specific nodes.
- Real research on a rumor
- Create content disproving a rumor
- clear winning/losing conditions


## What needs to be done

Wohoo I believe to be feature complete except for the stuff that I cut out!

## What got cut so far/until now?

- different characteristics of any kind (player, node, rumor, content for disproving rumor)
  - as part of that real rumor/node names...
- money as a resource
- randomly generated map - it is static for now but rumors get spread randomly
- events

# How to run?

A simple "rake" should do, what this does is executing "bin/siwoti"

# Original game description: Someone is wrong on the Internet!

http://xkcd.com/386/

You know it, someone is wrong on the Internet. Constantly. And it is your job to correct them. As a team you've got to get rid of all those myths and wrong information and spread the truth!

## The danger

The danger is present in the form of rumors and wrong information that spread through the Internet. So someone cites a bullshit statistic like "Humans only use 10% of their brain!" and it spreads like hell via various Internet services like Twitter. If a rumor is believed in by more than x% (maybe 80%) of the people, you lose the game.

Winning conditions: I'm not quite sure, maybe when you have completely extinguished 5 rumors (of course in reality this would never happen but well, it's a game). This could also be adjusted in order to vary the difficulty, so 3 for beginners and 7 for experts.

It's not so easy to convince people that a rumor is wrong. You can try to discover rumors early on, the earlier you discover a rumor the easier to stop the rumor is. Unfortunately it's not always easy to discover new rumors. Rumors spread pretty fast, and the more people believe in the rumor the more information you need to disprove it. So a simple blogpost won't be enough to extinguish a rumor 50% of the people believe in.

## Resources

The game basically has three resources:

- research - you need to do research in order to convincingly disprove a rumor (you can read books, try to find good resources on the internet etc...). So research is always bound to a rumor. The more you know about a rumor the better you may disprove it.
- money - you need money in order to faster get research, to attend conferences or in order to buy a camera etc. so you can make professional youtube videos
- time - you need time in order to gather the other resources or to try to discover new rumors

## Methods to disprove rumors

In order to disprove rumors you can try to create content in order to convince people that you are right (the list is by no means complete) :

- write a blogpost
- write some info on reddit
- create a youtube video (of varying quality)
- make a podcast
- write an email to a mailing list
- post an article on a page
- write a paper (during the course of the game you might bevome a member of IEEE or similiar organizations for added benefit)
- give a presentation at various places
- ...

Of course all of those take varying amounts of time/money and require a certain level of research on a rumor.

## Player Characters
I imagine that the 4 players could have different characters, they all earn varying amounts of money and have a varying amount of free time they start with. Also their knowledge level starts at a different level(knowledge level is increased when researching). Knowledge determines how fast you can generate research and how convincing you can be.

For instance there could be Manuel, a PhD - he doesn't have that much time but earns a solid amount of money and has a high knowledge level. In contrast to Joe, Joe was a slacker until now and doesn't have a job. He doesn't earn money and his knowledge level starts pretty low. But he has much free time, so you could use that to make him super intelligent or let him do the stupid tasks like searching for new rumors.

Furthermore Manuel has the possibility to join professional organisations for added benefit (like IEEE) whereas Joe hasn't. This however would be a very advanced feature.

## The problem: What about the graph-structure?

Together with other students we developed some ideas on how a graph structure might look for this (thanks to everyone who participated!), but I'm not really content with of any of those (feedback welcome!). Those ideas are meant as alternatives, so the game could just have one of these graph structures, I just don't know which one is best suited and maybe two of them could be mixed up into a single new idea. So please leave some feedback on this!

### Social groups as a graph
Rumors spread across social groups and some people are in more than one social group. These people form the connection between groups, some groups are well connected (they share many people) whereas some aren't connected or just by a bit. The better connected two social groups are, the faster ideas spread between them.

You may "visit" social groups in order to "cure" them of their disbeliefs.

It'd also be imaginable that they got different preferences, some groups can be reached best by Youtube, some via Facebook... and for some you have got to write a paper/book or give a presentation at a conference.

I like this idea, but it's kind of fuzzy. How to connect the different groups and decide what groups have what beliefs and affinity to which services? It could be to some degree random, which would be fun as every game would be different.

### Website users as nodes
The users of specific websites like reddit or wordpress are the nodes in the graph and when you post information on a node (wordpress for instance) it affects this node and ascending nodes (with decreasing efficiency). Problem: Which nodes are connected? Random?

Concerning the problem of how to connect the nodes, Pete had some very interesting ideas:

> * Use real world examples, like CNN, reddit and 4chan, and assign each of the nodes a score on a set of scales, like chaotic and orderly. So, CNN would be at one end of the spectrum wiht 0% chaotic and 100% orderly, while 4chan is the opposite, and reddit is somewhere in the middle but closer to 4chan, for instance. This way, CNN and 4chan are connected to different subgraphs and their memes would require several hops through intermediaries to infect each other.
>
> * Similar to the idea above, but replace the granular percentage system instead with a set number of traits, where each node has a certain number, and those affect the memes that a node can be infected with. Maybe a node can gain more traits (simulating popularity?) as the game goes on. So, for example, reddit starts the game with the programming trait, and gains "obsession with cats" and "Ron Paul support" as the game advances. Maybe as a meme gets more popular, it gains traits as well. I'm not sure this would make sense in all cases.
>
> * To combat the problem of things not making sense, you could use totally fictional nodes modeled after real ones perhaps. Then things would fall into categories like news site, forum, social news, etc. The nodes would be connected by perhaps a forum having a lot of respect for a certain news site, or something like that.

## Events

Oh and I like the idea of Events happening from time to time, maybe every round that shake up the game bit (like: "Oh no an agile team failed, belief in waterfall development on the rise!" or: "A celebrity said xyz... people start believing it.")

## Exercise Summary

- Design and model a game with the following features:
  - A map which can be represented as a graph structure
  - Rules that result in exponentially increasing danger as the game progresses
  - Resources which players must collect repeatedly in sets to win the game
  - Rules that create tension between slowing down immediate danger and
    collecting all the needed resources
- Create your own unique theme, don't copy the scenarios from the example games
- Implement at least a single player mode which demonstrates the game setup and the
  different actions that can take place on a turn.

