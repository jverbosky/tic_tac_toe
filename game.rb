require_relative "board/board.rb"
require_relative "board/position.rb"
require_relative "display/display.rb"
require_relative "players/player_perf.rb"
require_relative "players/player_rand.rb"
require_relative "players/player_seq.rb"

class Game

  attr_reader :p1_type, :p2_type, :player_type_current, :player_type_next, :mark_current, :mark_next
  attr_accessor :move, :round

  def initialize
    @board = Board.new  # Board class instance
    @position = Position.new  # Position class instance
    @display = Display.new  # Web class instance
    @round = 1  # current game round
    @p1 = ""  # Player class instance for X
    @p1_type = ""  # X player type ("Human", "Perfect", "Random", "Sequential")
    @p2 = ""  # Player class instance for O
    @p2_type = ""  # O player type ("Human", "Perfect", "Random", "Sequential")
    @player = ""  # Player class instance for current player
    @player_type_current = ""  # current player type
    @player_type_next = ""  # next player type
    @mark_current = ""  # current player character (X/O)
    @mark_next = ""  # next player character (O/X)
    @board_index = ""  # board array index value (based on @move)
    @wins = @board.wins  # constant needed by perfect player
  end

  # Method to output the game board
  def output_board
    rows = @board.game_board.each_slice(3).to_a
  end

  # Method to handle player type selection
  def select_players(player_type)
    @p1_type = player_type["p1_type"]
    case @p1_type
      when "Perfect" then @p1 = PlayerPerfect.new
      when "Random" then @p1 = PlayerRandom.new
      when "Sequential" then @p1 = PlayerSequential.new
    end
    @p2_type = player_type["p2_type"]
    case @p2_type
      when "Perfect" then @p2 = PlayerPerfect.new
      when "Random" then @p2 = PlayerRandom.new
      when "Sequential" then @p2 = PlayerSequential.new
    end
  end

  # Method to update @player, @player_type_ and @mark_ variables for view details
  def set_players
    if @round % 2 == 1
      @player = @p1
      @player_type_current = @p1_type
      @player_type_next = @p2_type
      @mark_current = "X"
      @mark_next = "O"
    else
      @player = @p2
      @player_type_current = @p2_type
      @player_type_next = @p1_type
      @mark_current = "O"
      @mark_next = "X"
    end
  end

  # Method to select appropriate route based on next player
  def get_route
    if @round == 1
      @p1_type == "Human" ? route = "/play_human" : route = "/play_ai"
    else
      @player_type_next == "Human" ? route = "/play_human" : route = "/play_ai"
    end
  end

  # Method to call human_move() or ai_move methods depending on player type
  def make_move(move)
    set_players  # update @player_, @player_type_ and @mark_ variables for current round
    @player_type_current == "Human" ? human_move(move) : ai_move  # move() call based on player type
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
    move = @player.get_move(@board.game_board, @round, @mark_current, @wins, @board.get_x, @board.get_o)
    convert_move(move)  # convert human friendly location name to board array index position
    @board.set_position(@board_index, @mark_current)  # then update the board
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
      @board.set_position(@board_index, @mark_current)  # if so, update the board
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

end

# game = Game.new
# types = {"p1_type"=>"Perfect", "p2_type"=>"Human"}
# game.select_players(types)
# puts "@p1_type: #{game.p1_type}"
# puts "@p2_type: #{game.p2_type}"
# # puts "@p1: #{game.p1}"
# # puts "@p2: #{game.p2}"
# game.round = 1
# puts "@round: #{game.round}"
# game.set_players
# # puts "@player: #{game.player}"
# puts "@player_type_current: #{game.player_type_current}"
# puts "@player_type_next: #{game.player_type_next}"
# game.set_marks
# puts "@mark_current: #{game.mark_current}"
# puts "@mark_next: #{game.mark_next}"
# # puts "@player: #{@player}"
# # puts "@player_type_current: #{@player_type_current}"


# game.board.game_board = ["", "X", "", "", "", "", "", "O", ""]
# game.board.game_board = ["X", "X", "X", "", "O", "", "", "O", ""]
# puts game.game_over?
# game.display_results
# p game.result
