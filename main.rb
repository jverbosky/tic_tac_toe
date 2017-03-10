###################################
# Program for running tic tac toe #
###################################

require_relative "game.rb"

# games_x_won = 0
# games_o_won = 0

start = Game.new
start.new_game

# puts "Games X Won: #{$games_x_won}"
# puts "Games O Won: #{$games_o_won}"

# Stress testing
# Loops until game over condition reached - use for stress testing
# while x_won == false && o_won == false && full == false
#   round = board.get_round(board.x_count, board.o_count)
#   round % 2 == 0 ? player = p2 : player = p1
#   mark = board.get_mark(board.x_count, board.o_count)
#   x_pos = board.get_x
#   o_pos = board.get_o
#   move = player.get_move(board.game_board, round, mark, wins, x_pos, o_pos)
#   location = position.get_index(move)
#   board.set_position(location, mark)
#   x_won = board.x_won?(board.get_x)
#   o_won = board.o_won?(board.get_o)
#   full = board.board_full?
# end