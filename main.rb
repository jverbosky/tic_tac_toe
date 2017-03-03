# Test program for running tic tac toe
# - trying now that player classes available to find gaps
#   (beyond initial setup - player selection, etc.)
#############################################################

require_relative "board.rb"
require_relative "player_seq.rb"
require_relative "player_rand.rb"
require_relative "turn.rb"
require_relative "position.rb"
require_relative "win.rb"
require_relative "console.rb"

# Initialize objects
board = Board.new
p1 = PlayerSequential.new
# p1 = PlayerRandom.new
# p2 = PlayerSequential.new
p2 = PlayerRandom.new
turn = Turn.new
position = Position.new
win = Win.new
console = Console.new

# Endgame condition checks
x_won = false
o_won = false
full = false

# Each iteration == 1 (attempted) move
while x_won == false && o_won == false && full == false
  round = turn.get_round(board.x_count, board.o_count)
  round % 2 == 0 ? player = p2 : player = p1
  mark = turn.get_mark(board.x_count, board.o_count)
  move = player.get_move(board.game_board)
  location = position.get_index(move)
  board.set_position(location, mark) if board.position_open?(location)
  x_won = win.x_won?(board.get_x)
  o_won = win.o_won?(board.get_o)
  full = board.board_full?
end

# Console output for game results (board and status)
console.output_board(board.game_board)
console.output_results(x_won, o_won)