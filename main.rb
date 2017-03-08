# Test program for running tic tac toe
# - trying now that player classes available to find gaps
#   (beyond initial setup - player selection, etc.)
#############################################################

require_relative "board.rb"
require_relative "player_perf.rb"
require_relative "player_seq.rb"
require_relative "player_rand.rb"
require_relative "position.rb"
require_relative "console.rb"

# Initialize objects
board = Board.new
p1 = PlayerPerfect.new
# p1 = PlayerRandom.new  # alternate p1
# p1 = PlayerSequential.new  # alternate p1
p2 = PlayerPerfect.new
# p2 = PlayerRandom.new  # alternate p2
# p2 = PlayerSequential.new  # alternate p2
position = Position.new
console = Console.new

# Constant needed by perfect player
wins = board.wins

# Endgame condition checks - default to false
x_won = false
o_won = false
full = false

# # Loops through until game over condition reached
# # Each iteration == 1 (attempted) move
# while x_won == false && o_won == false && full == false
#   round = board.get_round(board.x_count, board.o_count)  # puts round  # see the current round number
#   # puts round  # see the current round number
#   round % 2 == 0 ? player = p2 : player = p1  # puts player  # see which player moved during this turn
#   # puts player  # see which player moved during this turn
#   mark = board.get_mark(board.x_count, board.o_count)  # puts mark  # see which mark was used
#   # puts mark  # see which mark was used
#   x_pos = board.get_x
#   o_pos = board.get_o
#   move = player.get_move(board.game_board, round, mark, wins, x_pos, o_pos)  # puts move  # see what game_board position was selected
#   # puts move  # see what game_board position was selected
#   location = position.get_index(move)  # puts location  # see the corresponding game_board array index
#   # puts location  # see the corresponding game_board array index
#   board.set_position(location, mark)
#   x_won = board.x_won?(board.get_x)  # puts x_won  # see if x won (t/f)
#   # puts x_won  # see if x won (t/f)
#   o_won = board.o_won?(board.get_o)  # puts o_won  # see if o won (t/f)
#   # puts o_won  # see if o won (t/f)
#   full = board.board_full?  # puts full # see if the game_board is full (t/f)
#   # puts full # see if the game_board is full (t/f)
#   # p board.game_board  # view the game_board array
#   # p board.game_board  # view the game_board array
# end

# Need to add logic to:
#
# - Until game end conditions met
# 1) Run initialize and output_board at the end of each round
# 2) Collect user input to run loop again (press "n" or "space" or "enter" ?)
#
# - Once game end conditions met
# 1)  initialize, output_board and output results
#
# Each iteration == 1 (attempted) move
while x_won == false && o_won == false && full == false
  round = board.get_round(board.x_count, board.o_count)  # puts round  # see the current round number
  # puts round  # see the current round number
  round % 2 == 0 ? player = p2 : player = p1  # puts player  # see which player moved during this turn
  # puts player  # see which player moved during this turn
  mark = board.get_mark(board.x_count, board.o_count)  # puts mark  # see which mark was used
  # puts mark  # see which mark was used
  x_pos = board.get_x
  o_pos = board.get_o
  move = player.get_move(board.game_board, round, mark, wins, x_pos, o_pos)  # puts move  # see what game_board position was selected
  # puts move  # see what game_board position was selected
  location = position.get_index(move)  # puts location  # see the corresponding game_board array index
  # puts location  # see the corresponding game_board array index
  board.set_position(location, mark)
  x_won = board.x_won?(board.get_x)  # puts x_won  # see if x won (t/f)
  # puts x_won  # see if x won (t/f)
  o_won = board.o_won?(board.get_o)  # puts o_won  # see if o won (t/f)
  # puts o_won  # see if o won (t/f)
  full = board.board_full?  # puts full # see if the game_board is full (t/f)
  # puts full # see if the game_board is full (t/f)
  # p board.game_board  # view the game_board array
  # p board.game_board  # view the game_board array
end


# Console output for game results (board and status)
console.output_board(board.game_board)
console.output_results(x_won, o_won)