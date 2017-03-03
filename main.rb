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
# p1 = PlayerSequential.new  # alternate p1
p1 = PlayerRandom.new
p2 = PlayerSequential.new
# p2 = PlayerRandom.new  # alternate p2
turn = Turn.new
position = Position.new
win = Win.new
console = Console.new

# Endgame condition checks - default to false
x_won = false
o_won = false
full = false

# Each iteration == 1 (attempted) move
while x_won == false && o_won == false && full == false
  round = turn.get_round(board.x_count, board.o_count)  # puts round  # see the current round number
  round % 2 == 0 ? player = p2 : player = p1  # puts player  # see which player moved during this turn
  mark = turn.get_mark(board.x_count, board.o_count)  # puts mark  # see which mark was used
  move = player.get_move(board.game_board)  # puts move  # see what game_board position was selected
  location = position.get_index(move)  # puts location  # see the corresponding game_board array index
  board.set_position(location, mark)
  x_won = win.x_won?(board.get_x)  # puts x_won  # see if x won (t/f)
  o_won = win.o_won?(board.get_o)  # puts o_won  # see if o won (t/f)
  full = board.board_full?  # puts full # see if the game_board is full (t/f)
  # p board.game_board  # view the game_board array
end

# Console output for game results (board and status)
console.output_board(board.game_board)
console.output_results(x_won, o_won)