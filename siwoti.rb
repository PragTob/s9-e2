require_relative 'lib/player'
require_relative 'lib/game'

# Someone is wrong on the Internet
# This is the main file for console style gameplay

game = Game.new
game.initialize_players

puts "Welcome players!"
game.main_loop

