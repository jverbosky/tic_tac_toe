# Test program for running tic tac toe
# - trying now that player classes available to find gaps
#   (beyond initial setup - player selection, etc.)
#############################################################

# position_open?(position), set_position(position, mark), board_full?,
# get_x, get_o, x_won?, o_won?, x_count, o_count, get_board
require_relative "board.rb"
# get_move(round)
require_relative "player_seq.rb"
# get_move
require_relative "player_rand.rb"
# get_player(x_count, o_count), get_round(x_count, o_count)
require_relative "turn.rb"
# get_index(move)
require_relative "position.rb"

# Initialize objects
board = Board.new
p1 = PlayerSequential.new
p2 = PlayerRandom.new
turn = Turn.new
position = Position.new

# Endgame condition checks
x_won = board.x_won?
o_won = board.o_won?
full = board.board_full?

while x_won == false && o_won == false && full == false
  x = board.x_count
  o = board.o_count
  round = turn.get_round(x, o)
  puts round
  mark = turn.get_player(x, o)
  player = p1
  player = p2 if round % 2 == 0
  move = player.get_move(round)
  puts player
  puts move
  location = position.get_index(move)
  puts location
  board.set_position(location, mark) if board.position_open?(location)
  p board.get_board
end