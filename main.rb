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
# p1 = PlayerPerfect.new
# p1 = PlayerRandom.new  # alternate p1
# p1 = PlayerSequential.new  # alternate p1
# p2 = PlayerPerfect.new
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

# Player selection
console.clear_screen
puts "-" * 17
puts "   Tic Tac Toe"
puts "-" * 17
puts "          X"
puts "      O O X"
puts "      X"
puts "-" * 17
puts " Player options:"
puts "-" * 17
puts "  1 = human"
puts "  2 = perfect"
puts "  3 = random"
puts "  4 = sequential"
puts "-" * 30
print " Please select the X player: "
p1_type = ""
p2_type = ""
p1 = gets.chomp
if p1 == "1"
  p1_type = "human"
elsif p1 == "2"
  p1 = PlayerPerfect.new
  p1_type = "perfect"
elsif p1 == "3"
  p1 = PlayerRandom.new
  p1_type = "random"
elsif p1 == "4"
  p1 = PlayerSequential.new
  p1_type = "sequential"
else
  p1_type = "invalid"
end
puts "\n"
puts " Great!!!"
puts " X is a #{p1_type} player."
puts "-" * 30
print " Please select the O player: "
p2 = gets.chomp
if p2 == "1"
  p2_type = "human"
elsif p2 == "2"
  p2 = PlayerPerfect.new
  p2_type = "perfect"
elsif p2 == "3"
  p2 = PlayerRandom.new
  p2_type = "random"
elsif p2 == "4"
  p2 = PlayerSequential.new
  p2_type = "sequential"
else
  p2_type = "invalid"
end
puts "\n"
puts " Excellent!!!"
puts " O is a #{p2_type} player."
puts "-" * 30
puts " Please press Enter to begin!"
puts "-" * 30
start = gets.chomp

# Capture move and mark values to reference at the top of each iteration
move = ""
mark = ""
taken = false

# Each iteration == 1 (attempted) move
while x_won == false && o_won == false && full == false
  console.output_board(board.game_board)
  round = board.get_round(board.x_count, board.o_count)  # puts round  # see the current round number
  if round > 1
    puts "-" * 26
    puts " #{mark} selected #{move}."
    if taken == true
      puts "-" * 26
      puts " That position isn't open."
      puts "   * Please try again *"
    end
    puts "-" * 26
    puts " Press Enter to continue."
    puts "-" * 26
    input = gets.chomp
  end
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
  board.position_open?(location) ? taken = false : taken = true
  board.set_position(location, mark) if taken == false
  x_won = board.x_won?(board.get_x)  # puts x_won  # see if x won (t/f)
  # puts x_won  # see if x won (t/f)
  o_won = board.o_won?(board.get_o)  # puts o_won  # see if o won (t/f)
  # puts o_won  # see if o won (t/f)
  full = board.board_full?  # puts full # see if the game_board is full (t/f)
  # puts full # see if the game_board is full (t/f)
  # p board.game_board  # view the game_board array
  # p board.game_board  # view the game_board array
  if round == 1
    puts "-" * 26
    puts " The board is ready!"
    puts " Press Enter to continue."
    puts "-" * 26
    input = gets.chomp
  end
end

# # Loops through until game over condition reached - use for stress testing
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

# Console output for game results (board and status)
console.output_board(board.game_board)
console.output_results(x_won, o_won)
console.output_win(board.game_board)