require_relative "board.rb"
require_relative "player_hum.rb"
require_relative "player_perf.rb"
require_relative "player_rand.rb"
require_relative "player_seq.rb"
require_relative "position.rb"

class Game

  attr_reader :board, :position, :p1_type, :p2_type, :player_type, :mark, :taken, :x_won, :o_won, :game_over, :result, :win
  attr_accessor :move, :round

  def initialize
    @board = Board.new  # Board class instance
    @position = Position.new  # Position class instance
    @round = 1  # current game round
    @p1 = ""  # X player
    @p1_type = ""  # X player type
    @p2 = ""  # O player
    @p2_type = ""  # O player type
    @player = ""  # current player
    @player_type = ""  # current player type
    @mark = ""  # current player character (X/O)
    @move = ""  # plain English position selected by player
    @result = ""  # verbiage for winner
    @wins = @board.wins  # constant needed by perfect player
    @taken = false  # used to provide feedback when position occupied
    @x_won = false  # endgame condition check 1
    @o_won = false  # endgame condition check 2
    @full = false  # endgame condition check 3
    @game_over = false
    @win = []  # final winning positions
  end

  # Method to initialize objects and update @wins
  # def new_game
  #   @board = Board.new
  #   @position = Position.new
  #   @wins = @board.wins
  # end

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

  # Method to update @player and @player_type for make_move()
  def set_player_type
    if @round % 2 == 1
      @player = @p1
      @player_type = @p1_type
    else
      @player = @p2
      @player_type = @p2_type
    end
  end

  # Method to hold combined human & AI move logic
  def make_move(move)
    unless @player_type == "Human"
      @mark = @board.get_mark(@board.x_count, @board.o_count)
      @move = @player.get_move(@board.game_board, @round, @mark, @wins, @board.get_x, @board.get_o)
      location = @position.get_index(@move)
      @board.set_position(location, @mark)
      @round += 1
    else
      unless move == nil
        @mark = @board.get_mark(@board.x_count, @board.o_count)
        location = @position.get_index(move)
        @board.position_open?(location) ? @taken = false : @taken = true
        if @taken
          @result = "That position isn't open. Please try again Human"
        else
          @result = ""
          @board.set_position(location, @mark)
          @round += 1
        end
      else
        @round += 1
      end
    end
  end

  def game_over?
    @x_won = @board.x_won?(@board.get_x)
    @o_won = @board.o_won?(@board.get_o)
    @full = @board.board_full?
    @game_over = true if @x_won || @o_won || @full
    if @game_over == true
      @win = @position.map_win(@board.win)
      if @x_won == true
        $x_score += 1
        @result = "#{@p1_type} X won the game!<br>The winning positions were: #{@win}"
      elsif @o_won == true
        $o_score += 1
        @result = "#{@p2_type} O won the game!<br>The winning positions were: #{@win}"
      elsif @x_won == false && @o_won == false
        @result = "It was a tie!"
      end
    end
  end

end