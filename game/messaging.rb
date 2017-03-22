# class to handle web app messaging
class Messaging

  # @feedback and @prompt need to be available to app.rb routes
  attr_reader :feedback, :prompt
  attr_accessor :win

  def initialize
    @feedback = ""  # view messaging - move status or reprompt
    @prompt = ""  # view messaging - player advance prompt
    @win = ""  # populated with winning locations by end_game in Game class
  end

  # Method to update @feedback and @prompt if move is valid
  def valid_move(round, move, pt_current, m_current, pt_next, m_next)
    @feedback = "#{pt_current} #{m_current} took #{move} in round #{round}."
    @prompt = "Press <b>Next</b> for #{pt_next} #{m_next}'s move."
  end

  # Method to update @feedback with reprompt text if move is invalid
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

  # Method to display endgame messaging
  def display_results(p1_type, p2_type, winner)
    if winner == "X"
      return "#{p1_type} X won the game!<br>The winning positions were: #{win}"  # advise on win
    elsif winner == "O"
      return "#{p2_type} O won the game!<br>The winning positions were: #{win}"  # advise on win
    elsif winner == "tie"  # if no one won
      return "It was a tie!"  # advise on tie
    end
  end

end