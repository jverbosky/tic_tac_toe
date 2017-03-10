require_relative "board.rb"
require_relative "player_perf.rb"
require_relative "player_seq.rb"
require_relative "player_rand.rb"
require_relative "position.rb"
require_relative "console.rb"

class Game

  attr_reader :round, :mark, :move, :taken

  def initialize
    @board = ""  # Board class instance
    @position = ""  # Position class instance
    @console = ""  # Console class instance
    @round = 0  # current game round
    @p1 = ""  # X player
    @p2 = ""  # O player
    @mark = ""  # current player character (X/O)
    @move = ""  # plain English position selected by player
    @taken = false  # used to provide feedback when position occupied
    @x_won = false  # Endgame condition check 1
    @o_won = false  # Endgame condition check 2
    @full = false  # Endgame condition check 3
  end

  def select_players
    @console.select_players  # prompt for player type selection
    case @console.p1_type
      when "human" then puts "nothing yet"
      when "perfect" then @p1 = PlayerPerfect.new
      when "random" then @p1 = PlayerRandom.new
      when "sequential" then @p1 = PlayerSequential.new
      else puts "not a valid type"
    end
    case @console.p2_type
      when "human" then puts "nothing yet"
      when "perfect" then @p2 = PlayerPerfect.new
      when "random" then @p2 = PlayerRandom.new
      when "sequential" then @p2 = PlayerSequential.new
      else puts "not a valid type"
    end
  end

  def play_game
    select_players
    while @x_won == false && @o_won == false && @full == false  # Each iteration == 1 (attempted) move
      @console.output_board(@board.game_board)
      @round = @board.get_round(@board.x_count, @board.o_count)  # puts round  # see the current round number
      @console.move_status(@round, @mark, @move, @taken)
      @round % 2 == 0 ? player = @p2 : player = @p1
      @mark = @board.get_mark(@board.x_count, @board.o_count)
      wins = @board.wins  # Constant needed by perfect player
      @move = player.get_move(@board.game_board, @round, @mark, wins, @board.get_x, @board.get_o)
      location = @position.get_index(@move)
      @board.position_open?(location) ? @taken = false : @taken = true
      @board.set_position(location, @mark) if @taken == false
      @x_won = @board.x_won?(@board.get_x)
      @o_won = @board.o_won?(@board.get_o)
      @full = @board.board_full?
      @console.preamble if @round == 1
    end
  end

  # Method to display final game results
  def show_results
    translated = @position.map_win(@board.win)  # board array index positions in human-friendly positions
    @console.output_board(@board.game_board)
    @console.output_results(@x_won, @o_won, translated, @round, @mark, @move)
  end

  # Method to initialize objects and call play
  def new_game
    @board = Board.new
    @position = Position.new
    @console = Console.new
    play_game
    show_results
  end

end




#--------------Backup before splitting up new_game----------------------#

# class Game

#   def initialize
#     # @wins = board.wins  # Constant needed by perfect player
#     @x_won = false  # Endgame condition check 1
#     @o_won = false  # Endgame condition check 2
#     @full = false  # Endgame condition check 3
#     @move = ""  # updates at each loop iteration for status update
#     @mark = ""  # updates at each loop iteration for status update
#     @taken = false  # updates at each loop iteration for status update
#     @round = 0  # updates at each loop iteration for status update
#   end

#   def new_game

#     # Initialize objects
#     board = Board.new
#     position = Position.new
#     console = Console.new

#     wins = board.wins  # Constant needed by perfect player
#     console.select_players  # prompt for player type selection

#     case console.get_p1_type
#       when "human" then puts "nothing yet"
#       when "perfect" then p1 = PlayerPerfect.new
#       when "random" then p1 = PlayerRandom.new
#       when "sequential" then p1 = PlayerSequential.new
#       else puts "not a valid type"
#     end

#     case console.get_p2_type
#       when "human" then puts "nothing yet"
#       when "perfect" then p2 = PlayerPerfect.new
#       when "random" then p2 = PlayerRandom.new
#       when "sequential" then p2 = PlayerSequential.new
#       else puts "not a valid type"
#     end

#     # Each iteration == 1 (attempted) move
#     while @x_won == false && @o_won == false && @full == false
#       console.output_board(board.game_board)
#       @round = board.get_round(board.x_count, board.o_count)  # puts round  # see the current round number
#       if @round > 1
#         previous = @round - 1
#         puts "-" * 31
#         puts " " * 4 + "Round #{previous}: #{@mark} selected #{@move}"
#         if @taken == true
#           puts "-" * 31
#           puts " " * 3 + "That position isn't open!"
#           puts " " * 5 + "* Please try again *"
#         end
#         puts "-" * 31
#         puts " " * 4 + "Press Enter to continue."
#         puts "-" * 31
#         input = gets.chomp
#       end
#       @round % 2 == 0 ? player = p2 : player = p1
#       @mark = board.get_mark(board.x_count, board.o_count)
#       x_pos = board.get_x
#       o_pos = board.get_o
#       move = player.get_move(board.game_board, @round, @mark, wins, x_pos, o_pos)
#       location = position.get_index(move)
#       board.position_open?(location) ? @taken = false : @taken = true
#       board.set_position(location, @mark) if @taken == false
#       @x_won = board.x_won?(board.get_x)
#       @o_won = board.o_won?(board.get_o)
#       @full = board.board_full?
#       console.opening if @round == 1
#     end

#     # Game results output
#     win = board.get_win  # winning position, needed by console.output_results
#     translated = position.map_win(win)  # board array index positions in human-friendly positions
#     console.output_board(board.game_board)
#     console.output_results(@x_won, @o_won, translated, @round, @mark, @move)

#   end

# end




#--------------Backup - before converting to class---------------------------#

# class Game

#   def new_game

#     # Initialize objects
#     board = Board.new
#     position = Position.new
#     console = Console.new

#     # Game variables
#     wins = board.wins  # Constant needed by perfect player
#     x_won = false  # Endgame condition check 1
#     o_won = false  # Endgame condition check 2
#     full = false  # Endgame condition check 3
#     move = ""  # updates at each loop iteration for status update
#     mark = ""  # updates at each loop iteration for status update
#     taken = false  # updates at each loop iteration for status update
#     round = 0  # updates at each loop iteration for status update

#     console.select_players  # prompt for player type selection

#     case console.get_p1_type
#       when "human" then puts "nothing yet"
#       when "perfect" then p1 = PlayerPerfect.new
#       when "random" then p1 = PlayerRandom.new
#       when "sequential" then p1 = PlayerSequential.new
#       else puts "not a valid type"
#     end

#     case console.get_p2_type
#       when "human" then puts "nothing yet"
#       when "perfect" then p2 = PlayerPerfect.new
#       when "random" then p2 = PlayerRandom.new
#       when "sequential" then p2 = PlayerSequential.new
#       else puts "not a valid type"
#     end

#     # Each iteration == 1 (attempted) move
#     while x_won == false && o_won == false && full == false
#       console.output_board(board.game_board)
#       round = board.get_round(board.x_count, board.o_count)  # puts round  # see the current round number
#       if round > 1
#         previous = round - 1
#         puts "-" * 31
#         puts " " * 4 + "Round #{previous}: #{mark} selected #{move}"
#         if taken == true
#           puts "-" * 31
#           puts " " * 3 + "That position isn't open!"
#           puts " " * 5 + "* Please try again *"
#         end
#         puts "-" * 31
#         puts " " * 4 + "Press Enter to continue."
#         puts "-" * 31
#         input = gets.chomp
#       end
#       round % 2 == 0 ? player = p2 : player = p1
#       mark = board.get_mark(board.x_count, board.o_count)
#       x_pos = board.get_x
#       o_pos = board.get_o
#       move = player.get_move(board.game_board, round, mark, wins, x_pos, o_pos)
#       location = position.get_index(move)
#       board.position_open?(location) ? taken = false : taken = true
#       board.set_position(location, mark) if taken == false
#       x_won = board.x_won?(board.get_x)
#       o_won = board.o_won?(board.get_o)
#       full = board.board_full?
#       console.opening if round == 1
#     end

#     # Game results output
#     win = board.get_win  # winning position, needed by console.output_results
#     translated = position.map_win(win)  # board array index positions in human-friendly positions
#     console.output_board(board.game_board)
#     console.output_results(x_won, o_won, translated, round, mark, move)

#   end

# end

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