# class to handle web app messaging
class Messaging

  # @feedback and @prompt need to be available to app.rb routes
  attr_reader :feedback, :prompt
  attr_accessor :win

  def initialize
    # @move = ""  # view messaging - current player's move
    # @pt_current = ""  # view messaging - current player type
    # @pt_next = ""  # view messaging - next player type
    # @m_current = ""  # view messaging - current player character (X/O)
    # @m_next = ""  # view messaging - next player character (O/X)
    @feedback = ""  # view messaging - move status or reprompt
    @prompt = ""  # view messaging - player advance prompt
    @win = []  # populated with winning positions by game_over? in Game class
  end

  # Method to update @feedback and @prompt if move is valid
  def valid_move(round, move, pt_current, m_current, pt_next, m_next)
    # if valid_move?  # if the move is valid, update messaing and increment round
      # @feedback = "#{@player_type_current} #{@mark_current} took #{@move} in round #{@round}."
      @feedback = "#{pt_current} #{m_current} took #{move} in round #{round}."
      # @prompt = "Press <b>Next</b> for #{@player_type_next} #{@mark_next}'s move."
      @prompt = "Press <b>Next</b> for #{pt_next} #{m_next}'s move."
      # @round += 1  # increment the round count by 1
    # else  # otherwise, update @feedback with reprompt text
    #   @feedback = "That position isn't open. Try again Human #{m_current}."
    # end
  end

  # Method to update @feedback with reprompt text
  def invalid_move(m_current)
    @feedback = "That position isn't open. Try again Human #{m_current}."
  end

  # Method to handle /play_human view messaging for human players
  def human_messaging(round, mark)
    if round <= 2  # if it's round 1 or 2, use messaging for X/O's first move
      return "It's Human #{mark}'s move!"
    else  # otherwise use messaging for subsequent moves
      return "It's Human #{mark}'s move again!"
    end
  end

  # Method to select appropriate route based on next player's type
  def get_route(pt_next)
    # if round == 1  # select round 1 route based on player 1's type
      # @p1_type == "Human" ? route = "/play_human" : route = "/play_ai"
      pt_next == "Human" ? route = "/play_human" : route = "/play_ai"
    # else  # otherwise select the route based on the next player's type
    #   # @player_type_next == "Human" ? route = "/play_human" : route = "/play_ai"
    #   player_type == "Human" ? route = "/play_human" : route = "/play_ai"
    # end
  end

  # Method to display endgame messaging
  def display_results(p1_type, p2_type, winner)
    # win = @position.map_win(@win.win)  # get the winning positions
    if winner == "X"
    # if @win.x_won?  # if X won
    #   $x_score += 1  # increment X's score by 1
      return "#{p1_type} X won the game!<br>The winning positions were: #{win}"  # advise on win
    elsif winner == "O"
    # elsif @win.o_won?  # if O won
    #   $o_score += 1  # increment O's score by 1
      return "#{p2_type} O won the game!<br>The winning positions were: #{win}"  # advise on win
    elsif winner == "tie"
    # elsif !@win.x_won? && !@win.o_won?  # if no one won
      return "It was a tie!"  # advise on tie
    end
  end

end