###################################
# Program for running tic tac toe #
###################################

# require_relative "board.rb"
# require_relative "player_perf.rb"
# require_relative "player_seq.rb"
# require_relative "player_rand.rb"
# require_relative "position.rb"
# require_relative "console.rb"
require_relative "game.rb"

start = Game.new
start.new_game


# $games_x_won = 0
# $games_o_won = 0

# def new_game

#   # Initialize objects
#   board = Board.new
#   position = Position.new
#   console = Console.new

#   # Game variables
#   wins = board.wins  # Constant needed by perfect player
#   x_won = false  # Endgame condition check 1
#   o_won = false  # Endgame condition check 2
#   full = false  # Endgame condition check 3
#   move = ""  # updates at each loop iteration for status update
#   mark = ""  # updates at each loop iteration for status update
#   taken = false  # updates at each loop iteration for status update
#   round = 0  # updates at each loop iteration for status update

#   console.select_players  # prompt for player type selection

#   case console.get_p1_type
#     when "human" then puts "nothing yet"
#     when "perfect" then p1 = PlayerPerfect.new
#     when "random" then p1 = PlayerRandom.new
#     when "sequential" then p1 = PlayerSequential.new
#     else puts "not a valid type"
#   end

#   case console.get_p2_type
#     when "human" then puts "nothing yet"
#     when "perfect" then p2 = PlayerPerfect.new
#     when "random" then p2 = PlayerRandom.new
#     when "sequential" then p2 = PlayerSequential.new
#     else puts "not a valid type"
#   end

#   # Each iteration == 1 (attempted) move
#   while x_won == false && o_won == false && full == false
#     console.output_board(board.game_board)
#     round = board.get_round(board.x_count, board.o_count)  # puts round  # see the current round number
#     if round > 1
#       previous = round - 1
#       puts "-" * 31
#       puts " " * 4 + "Round #{previous}: #{mark} selected #{move}"
#       if taken == true
#         puts "-" * 31
#         puts " " * 3 + "That position isn't open!"
#         puts " " * 5 + "* Please try again *"
#       end
#       puts "-" * 31
#       puts " " * 4 + "Press Enter to continue."
#       puts "-" * 31
#       input = gets.chomp
#     end
#     round % 2 == 0 ? player = p2 : player = p1
#     mark = board.get_mark(board.x_count, board.o_count)
#     x_pos = board.get_x
#     o_pos = board.get_o
#     move = player.get_move(board.game_board, round, mark, wins, x_pos, o_pos)
#     location = position.get_index(move)
#     board.position_open?(location) ? taken = false : taken = true
#     board.set_position(location, mark) if taken == false
#     x_won = board.x_won?(board.get_x)
#     $games_x_won += 1 if x_won
#     o_won = board.o_won?(board.get_o)
#     $games_o_won += 1 if o_won
#     full = board.board_full?
#     console.opening if round == 1
#   end

#   # Game results output
#   win = board.get_win  # winning position, needed by console.output_results
#   translated = position.map_win(win)  # board array index positions in human-friendly positions
#   console.output_board(board.game_board)
#   console.output_results(x_won, o_won, translated, round, mark, move)

# end

# def start_game
#   new_game

# end

# start = Game.new
# start.new_game

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