require_relative "board/board.rb"
require_relative "board/position.rb"
require_relative "display/display.rb"
require_relative "players/player_perf.rb"
require_relative "players/player_rand.rb"
require_relative "players/player_seq.rb"

class Game

  attr_reader :p1_type, :p2_type
  attr_accessor :move, :round

  def initialize
    @board = Board.new  # Board class instance
    @position = Position.new  # Position class instance
    @display = Display.new  # Web class instance
    @round = 1  # current game round
    @p1 = ""  # X player
    @p1_type = ""  # X player type
    @p2 = ""  # O player
    @p2_type = ""  # O player type
    @player = ""  # current player
    @player_type = ""  # current player type
    @mark = ""  # current player character (X/O)
    @board_index = ""  # board array index value (based on @move)
    @wins = @board.wins  # constant needed by perfect player
    # @route = ""  # used for Sinatra route selection
  end

  # Method to output the game board
  def output_board
    rows = @board.game_board.each_slice(3).to_a
  end

  # Method to handle player type selection
  def select_players(player_type)
    @p1_type = player_type["p1_type"]
    case @p1_type
      # when "Human" then @p1 = PlayerHuman.new
      when "Perfect" then @p1 = PlayerPerfect.new
      when "Random" then @p1 = PlayerRandom.new
      when "Sequential" then @p1 = PlayerSequential.new
    end
    @p2_type = player_type["p2_type"]
    case @p2_type
      # when "Human" then @p2 = PlayerHuman.new
      when "Perfect" then @p2 = PlayerPerfect.new
      when "Random" then @p2 = PlayerRandom.new
      when "Sequential" then @p2 = PlayerSequential.new
    end
  end

  # Method to update @player for make_move() and @player_type for ai_move
  def set_player_type
    if @round % 2 == 1
      @player = @p1
      @player_type = @p1_type
    else
      @player = @p2
      @player_type = @p2_type
    end
  end

  # Method to determine if player mark is X or O
  # Good candidate for revision - simply abstracting at the moment
  def determine_mark
    @mark = @board.get_mark(@board.x_count, @board.o_count)  # determine if player mark is X or O
  end

  # Method to call human_move() or ai_move methods depending on player type
  def make_move(move)
    determine_mark  #  determine player mark (X/O)
    set_player_type  # update @player and @player_type for generalized use
    @player_type == "Human" ? human_move(move) : ai_move  # move() call based on player type
  end

  # Method to handle human move logic
  # Update candidate > return move instead of using instance variable
  def human_move(move)
    convert_move(move)  # convert human friendly location name to board array index position
    check_taken  # determine if location is taken and act accordingly
  end

  # Method to handle ai move logic
  # Update candidate > return move instead of using instance variable
  def ai_move
    move = @player.get_move(@board.game_board, @round, @mark, @wins, @board.get_x, @board.get_o)
    convert_move(move)  # convert human friendly location name to board array index position
    @board.set_position(@board_index, @mark)  # then update the board
    @round += 1  # increment the round count by 1
    return move  # return the move for use in round info messaging
  end

  # Method to convert human friendly location name to board array index position
  def convert_move(move)
    @board_index = @position.get_index(move)  # update @board_index with index value
  end

  # Method that provides feedback if position is taken or updates the board if position is open
  def check_taken
    if @board.position_open?(@board_index) # determine if position open
      @board.set_position(@board_index, @mark)  # if so, update the board
      @round += 1  # increment the round count by 1
      return ""  # clear any feedback (used for comparisons in /result_human route and human views)
    else  # if position is already taken
      return "That position isn't open. Try again Human"  # return appropriate feedback
    end
  end

  # Method to determine if game is over based on conditions (x won, o won, board full)
  def game_over?
    @board.x_won?(@board.get_x) || @board.o_won?(@board.get_o) || @board.board_full?
  end

  # Method to display endgame messaging
  def display_results
    win = @position.map_win(@board.win)  # get the winning positions
    if @board.x_won?(@board.get_x)  # if X won
      $x_score += 1  # increment X's score by 1
      return "#{@p1_type} X won the game!<br>The winning positions were: #{win}"  # advise on win
    elsif @board.o_won?(@board.get_o)  # if O won
      $o_score += 1  # increment O's score by 1
      return "#{@p2_type} O won the game!<br>The winning positions were: #{win}"  # advise on win
    elsif !@board.x_won?(@board.get_x) && !@board.o_won?(@board.get_o)  # if no one won
      return "It was a tie!"  # advise on tie
    end
  end

  def get_route
    if @p1_type == "Human"
      route = "/play_human"
    else
      route = "/play_ai"
    end
  end

end

# game = Game.new
# # game.board.game_board = ["", "X", "", "", "", "", "", "O", ""]
# game.board.game_board = ["X", "X", "X", "", "O", "", "", "O", ""]
# puts game.game_over?
# game.display_results
# p game.result