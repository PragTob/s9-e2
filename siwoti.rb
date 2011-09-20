require_relative 'lib/player'
require_relative 'lib/game'

# Someone is wrong on the Internet
# This is the main file for console style gameplay

puts "Welcome to Someone is wrong on the Internet (siwoti)"
puts "How many players will join this game?"
number_of_players = gets.chomp.to_i

number_of_players.times do |i|
  puts "Hey player #{i+1}! What's your name?"
  Game.add_player(gets.chomp)
end

puts "Welcome players!"
Game.players.each do |player|
  puts player.to_s + " it's your turn! We are in round #{Game.round}"
  puts "What do you want to do?"
  puts "[c]reate content disproving a rumor?"
  puts "[r]esearch information on a rumor?"
  puts "[s]earch for new rumors on the Internet?"
  puts "[d]isplay information about the currently known rumors?"
  puts "[v]iew the map?"
end

