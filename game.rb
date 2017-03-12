require_relative "board.rb"
require_relative "player_hum.rb"
require_relative "player_perf.rb"
require_relative "player_rand.rb"
require_relative "player_seq.rb"
require_relative "position.rb"

class Game

  attr_reader :round, :mark, :taken, :p1_type, :p2_type, :game_over, :x_won, :o_won
  attr_accessor :move

  # Variables for scores (global to persist through new game instances)
  $x_score = 0  # accumulator for X score
  $o_score = 0  # accumulator for O score
  # $game_over = false

  def initialize
    @board = ""  # Board class instance
    @position = ""  # Position class instance
    @round = 1  # current game round
    @p1 = ""  # X player
    @p1_type = ""  # X player type
    @p2 = ""  # O player
    @p2_type = ""  # O player type
    @mark = ""  # current player character (X/O)
    @move = ""  # plain English position selected by player
    @taken = false  # used to provide feedback when position occupied
    @x_won = false  # endgame condition check 1
    @o_won = false  # endgame condition check 2
    @full = false  # endgame condition check 3
    @game_over = false
  end

  # Method to initialize objects, call game loop and display endgame results
  def new_game
    @board = Board.new
    @position = Position.new
    # @board.game_board = ["X", "", "X", "O", "O", "X", "X", "", ""]  # for output testing
    # play_game
    # show_results
    # play_again?
  end

  # Method to output the game board
  def output_board
    rows = @board.game_board.each_slice(3).to_a
  end

  # Method to handle player type selection
  def select_players(player_type)
    @p1_type = player_type["p1_type"]
    case @p1_type
      when "Human" then @p1 = PlayerHuman.new
      when "Perfect" then @p1 = PlayerPerfect.new
      when "Random" then @p1 = PlayerRandom.new
      when "Sequential" then @p1 = PlayerSequential.new
    end
    @p2_type = player_type["p2_type"]
    case @p2_type
      when "Human" then @p2 = PlayerHuman.new
      when "Perfect" then @p2 = PlayerPerfect.new
      when "Random" then @p2 = PlayerRandom.new
      when "Sequential" then @p2 = PlayerSequential.new
    end
  end

  # def human_move(move)
  #   @mark = @board.get_mark(@board.x_count, @board.o_count)
  #   location = @position.get_index(move)
  #   @board.position_open?(location) ? @taken = false : @taken = true
  #   @board.set_position(location, @mark) if @taken == false
  # end

  # def ai_move
  #   wins = @board.wins  # constant needed by perfect player
  #   @mark = @board.get_mark(@board.x_count, @board.o_count)
  #   @move = @p1.get_move(@board.game_board, @round, @mark, wins, @board.get_x, @board.get_o)
  #   location = @position.get_index(@move)
  #   @board.position_open?(location) ? @taken = false : @taken = true
  #   @board.set_position(location, @mark) if @taken == false
  # end

  # Method to handle main game loop
  def play_game
    # select_players
    # while @x_won == false && @o_won == false && @full == false  # Each iteration == 1 (attempted) move
      # @display.output_board(@board.game_board, $x_score, $o_score)
      # @round = @board.get_round(@board.x_count, @board.o_count)  # puts round  # see the current round number
      @round % 2 == 0 ? (player = @p2; player_type = @p2_type) : (player = @p1; player_type = @p1_type)
      # @display.move_status(@round, @mark, @move, @taken)  # display previous round info
      # @display.computer unless @p1_type == "human" || @p2_type == "human"
      @mark = @board.get_mark(@board.x_count, @board.o_count)
      wins = @board.wins  # constant needed by perfect player
      unless player_type == "Human"
        @move = player.get_move(@board.game_board, @round, @mark, wins, @board.get_x, @board.get_o)
      end
      location = @position.get_index(@move)
      @board.position_open?(location) ? @taken = false : @taken = true
      @board.set_position(location, @mark) if @taken == false
      @x_won = @board.x_won?(@board.get_x)
      # $x_score += 1 if @x_won
      @o_won = @board.o_won?(@board.get_o)
      # $o_score += 1 if @o_won
      @full = @board.board_full?
      if @x_won || @o_won || @full
        @game_over = true
      end
      @round += 1
    # end
  end

  # Method to display final game results
  def show_results
    translated = @position.map_win(@board.win)  # board array index positions in human-friendly positions
    # @display.output_board(@board.game_board, $x_score, $o_score)
    # @display.output_results(@x_won, @o_won, translated, @round, @mark, @move)
  end

  def play_again?
    # @display.play_again?
    # if @display.key == "y"  # or any key except "q"
    #   play
    # elsif @display.key == "q"
    #   $game_over = true
    # end
  end

  # Method to start a new game
  def play
    initialize
    new_game
  end

end

# game = Game.new
# position = Position.new

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