require_relative 'lib/dependencies'

# Someone is wrong on the Internet
# This is the main file for console style gameplay

game = Siwoti::Game.new
game.initialize_players

puts "Welcome players!"
game.main_loop

