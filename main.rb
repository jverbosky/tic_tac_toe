###################################
# Program for running tic tac toe #
###################################

require_relative "game.rb"

new_game = Game.new

def start_game(new_game)
  while $game_over == false
    new_game.play
  end
end

# start_game(new_game)