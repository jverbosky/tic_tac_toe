require_relative "win.rb"
require_relative "../board/board.rb"
require_relative "../board/position.rb"
require_relative "../players/player_perf.rb"
require_relative "../players/player_rand.rb"
require_relative "../players/player_seq.rb"

class Game

  attr_reader :p1_type, :p2_type, :feedback, :prompt
  attr_accessor :move, :round

  def initialize
    @board = Board.new  # Board class instance
    @position = Position.new  # Position class instance
    @win = Win.new  # Win class instance
    @round = 1  # current game round
    @p1 = ""  # Player object instance for X
    @p1_type = ""  # X player type ("Human", "Perfect", "Random", "Sequential")
    @p2 = ""  # Player object instance for O
    @p2_type = ""  # O player type ("Human", "Perfect", "Random", "Sequential")
    @player = ""  # used to generically collect AI player move
    @player_type_current = ""  # view messaging - current player type
    @player_type_next = ""  # view messaging - next player type
    @mark_current = ""  # view messaging - current player character (X/O)
    @mark_next = ""  # view messaging - next player character (O/X)
    @move = ""  # view messaging - current player's move
    @board_index = ""  # board array index value (based on @move)
    @feedback = ""  # view messaging - move status or reprompt
    @prompt = ""  # view messaging - player advance prompt
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

  # Method to update instance variables for AI move collection and view messaging
  def set_players
    if @round % 2 == 1  # X is current if odd-numbered round
      @player = @p1
      @player_type_current = @p1_type
      @player_type_next = @p2_type
      @mark_current = "X"
      @mark_next = "O"
    else  # otherwise O is current
      @player = @p2
      @player_type_current = @p2_type
      @player_type_next = @p1_type
      @mark_current = "O"
      @mark_next = "X"
    end
  end

  # Method to call human_move() or ai_move methods depending on player type
  def make_move(move)
    set_players  # update @player_, @player_type_ and @mark_ variables for current round
    @player_type_current == "Human" ? human_move(move) : ai_move  # move() call based on player type
    convert_move  # convert human friendly location name to board array index position
    update_messaging  # evaluate move and update messaging accordingly
  end

  # Method to assign move to @move instance variable for ease-of-access
  def human_move(move)
    @move = move
  end

  # Method to collect move from AI player instance
  def ai_move
    # @move = @player.get_move(@board.game_board, @round, @mark_current, @board.wins, @board.get_x, @board.get_o)
    @move = @player.get_move(@board.game_board, @round, @mark_current, @win.wins, @board.get_x, @board.get_o)
  end

  # Method to convert human friendly location name to board array index position
  def convert_move
    @board_index = @position.get_index(@move)  # update @board_index with index value
  end

  # Method that updates the board if position is open, called by update_messaging
  def valid_move?
    if @board.position_open?(@board_index) # determine if position open
      @board.set_position(@board_index, @mark_current)  # if so, update the board
      return true  # drives selection of if statements in update_messaging
    else  # if position is already taken
      return false  # drives selection of else statement in update_messaging
    end
  end

  #Method to update round messaging and count if move is valid
  def update_messaging
    if valid_move?  # if the move is valid, update messaing and increment round
      @feedback = "#{@player_type_current} #{@mark_current} took #{@move} in round #{@round}."
      @prompt = "Press <b>Next</b> for #{@player_type_next} #{@mark_next}'s move."
      @round += 1  # increment the round count by 1
    else  # otherwise, update @feedback with reprompt text
      @feedback = "That position isn't open. Try again Human #{@mark_current}."
    end
  end

  # Method to handle /play_human view messaging for human players
  def human_messaging
    if @round <= 2  # if it's round 1 or 2, use messaging for X/O's first move
      return "It's Human #{@mark_current}'s move!"
    else  # otherwise use messaging for subsequent moves
      return "It's Human #{@mark_current}'s move again!"
    end
  end

  # Method to select appropriate route based on next player
  def get_route
    if @round == 1  # select round 1 route based on player 1's type
      @p1_type == "Human" ? route = "/play_human" : route = "/play_ai"
    else  # otherwise select the route based on the next player's type
      @player_type_next == "Human" ? route = "/play_human" : route = "/play_ai"
    end
  end

  # Method to determine if game is over based on conditions (x won, o won, board full)
  def game_over?
    @win.update_board(@board.game_board)  ## new ##
    @win.x_won? || @win.o_won? || @win.board_full?  ## new ##
    # @board.x_won?(@board.get_x) || @board.o_won?(@board.get_o) || @board.board_full?
  end

  # Method to display endgame messaging
  def display_results
    # win = @position.map_win(@board.win)  # get the winning positions
    win = @position.map_win(@win.win)  # get the winning positions
    # if @board.x_won?(@board.get_x)  # if X won
    if @win.x_won?  # if X won
      $x_score += 1  # increment X's score by 1
      return "#{@p1_type} X won the game!<br>The winning positions were: #{win}"  # advise on win
    # elsif @board.o_won?(@board.get_o)  # if O won
    elsif @win.o_won?  # if O won
      $o_score += 1  # increment O's score by 1
      return "#{@p2_type} O won the game!<br>The winning positions were: #{win}"  # advise on win
    # elsif !@board.x_won?(@board.get_x) && !@board.o_won?(@board.get_o)  # if no one won
    elsif !@win.x_won? && !@win.o_won?  # if no one won
      return "It was a tie!"  # advise on tie
    end
  end

end