require_relative "board.rb"
require_relative "player_hum.rb"
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

  # Method to initialize objects, call game loop and display endgame results
  def new_game
    @board = Board.new
    @position = Position.new
    @console = Console.new
    play_game
    show_results
  end

  # Method to handle player type selection
  def select_players
    @console.select_players  # prompt for player type selection
    case @console.p1_type
      when "human" then @p1 = PlayerHuman.new
      when "perfect" then @p1 = PlayerPerfect.new
      when "random" then @p1 = PlayerRandom.new
      when "sequential" then @p1 = PlayerSequential.new
      else puts "not a valid type"
    end
    case @console.p2_type
      when "human" then @p2 = PlayerHuman.new
      when "perfect" then @p2 = PlayerPerfect.new
      when "random" then @p2 = PlayerRandom.new
      when "sequential" then @p2 = PlayerSequential.new
      else puts "not a valid type"
    end
  end

  # Method to handle main game loop
  def play_game
    select_players
    while @x_won == false && @o_won == false && @full == false  # Each iteration == 1 (attempted) move
      @console.output_board(@board.game_board)
      @round = @board.get_round(@board.x_count, @board.o_count)  # puts round  # see the current round number
      @console.move_status(@round, @mark, @move, @taken)
      @round % 2 == 0 ? player = @p2 : player = @p1
      @mark = @board.get_mark(@board.x_count, @board.o_count)
      wins = @board.wins  # constant needed by perfect player
      @move = player.get_move(@board.game_board, @round, @mark, wins, @board.get_x, @board.get_o)
      location = @position.get_index(@move)  # translate plain English position into array value
      @board.position_open?(location) ? @taken = false : @taken = true
      @board.set_position(location, @mark) if @taken == false
      @x_won = @board.x_won?(@board.get_x)
      @o_won = @board.o_won?(@board.get_o)
      @full = @board.board_full?
      @console.preamble if @round == 1  # introductory verbiage
    end
  end

  # Method to display final game results
  def show_results
    translated = @position.map_win(@board.win)  # board array index positions in human-friendly positions
    @console.output_board(@board.game_board)
    @console.output_results(@x_won, @o_won, translated, @round, @mark, @move)
  end

end

# Old stress testing code that only displays final game screen (just for reference)
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