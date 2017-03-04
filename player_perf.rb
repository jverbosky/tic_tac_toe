require_relative "board.rb"

# class for computer player that plays perfectly to a win or a tie
class PlayerPerfect

  def initialize
    @moves = ["t1", "t2", "t3", "m1", "m2", "m3", "b1", "b2", "b3"]
    @corners = [0, 2, 6, 8]
    @edges = [1, 3, 5, 7]
    @center = [4]
  end

  # Method to return position to win, false if none
  def move(wins, player, opponent)
    position = []
    wins.each do |win|
      difference = win - player  # difference between current win array and player position array
      if difference.count == 1  # if player 1 move from win, take position unless already opponent mark
        position.push(difference[0]) unless (opponent & difference).count == 1
      end
    end
    # non-perfect "temporary code"
    if position.count == 0  # if nothing to block or win, randomly collect an open position
      position.push((Array(0..8) - (player + opponent)).sample)
    end
    position.sample  # .sample in case of multiple
  end

  # Method to return position to block, call win() if nothing to block
  def block(wins, player, opponent)
    position = []
    wins.each do |win|
      difference = win - opponent  # difference between current win array and opponent position array
      if difference.count == 1  # if opponent 1 move from win, block position unless already player mark
        position.push(difference[0]) unless (player & difference).count == 1
      end
    end
    position.count > 0 ? position.sample : move(wins, player, opponent)  # .sample in case of multiple
  end

  # Method to handle o logic for opening rounds
  def opening_o(round)
    # position = false
    case round
      when 2 then position = 4  # take the center
      when 4 then position = [1, 3, 5, 7].sample  # take an edge
    end
    # position
  end

  # Method to get opposite corner when O selects center in round 2
  def o_center(player)
    case player
      when [0] then position = 8
      when [2] then position = 6
      when [6] then position = 2
      when [8] then position = 0
    end
  end

# X - O     X - O     X - O
# - - -  >  - O -  >  - O -
# - - X     - - X     X - X

# board.game_board = ["X", "", "O", "", "O", "", "", "", "X"]  # round 5 - O took corner, variation 1 (b1)

  # Method to handle corner selection when O selects a corner in round 2
  def o_corner(player, opponent)
    p player
    p opponent
    opposites_1 = [0, 8]
    opposites_2 = [2, 6]
    taken = player + opponent  # get corners to compare again opposites pairs
    # if player & opponent corners are opposite, take an empty corner
    if (taken - opposites_1).size == 0 || (taken - opposites_2).size == 0
      puts "1"
      available = @corners - taken
      position = available.sample
    # round 5 - if opponent took a non-corner position, take last open corner
    elsif (taken - @corners).size > 0
      intersection = taken & @corners
      position = (@corners - intersection)[0]
    # if not, figure out which corner is the opposite and take it
    elsif (opposites_1 - player).size == 1
      puts "2"
      position = (opposites_1 - player)[0]
    else
      puts "3"
      position = (opposites_2 - player)[0]
    end
  end

#-----------------------------------------------------------------------------
# Currently have round 2 & 3 logic (first O move, second X move):
# - O takes edge, X takes center
# - O takes center, X takes opposite corner
# - O takes corner, X takes opposite corner if open or a random corner if not
#-----------------------------------------------------------------------------
# Continue with round 4 & 5 logic (second O move, third X move):
#-----------------------------------------------------------------------------
# Edge
# - O takes corner opposite one X took in round 1, X can take a corner for two paths to win
# - Any pattern to figure out X move or just write out?
#
# X O -     X O -
# - X -  >  - X -
# - - O     X - O
#
#-----------------------------------------------------------------------------
# Center
# - O should take an edge in round 4 after taking center (perfect player) to force X to block
# - if O takes a corner, X should take other corner for two paths to win
#
# X - O     X - O
# - O -  >  - O -
# - - X     X - X
#
#-----------------------------------------------------------------------------
# Corner
# - If O took a corner in round 2, forced to block in round 4
#
# Variation 1: O takes non-opposite corner, forced to block in middle
# - X takes last open corner in round 5
#
# X - O     X - O     X - O
# - - -  >  - O -  >  - O -
# - - X     - - X     X - X
#
# Variation 2: O takes opposite corner
# - X takes last open corner in round 5
#
# X - X     X O X     X O X
# - - -  >  - - -  >  - - -
# - - O     - - O     X - O
#-----------------------------------------------------------------------------

  # Method to handle x logic for opening rounds
  def opening_x(wins, player, opponent, round)
    if round == 1
      position = [0, 2, 6, 8].sample  # take a corner, any corner
    elsif round == 3
      if (opponent & @edges).size > 0  # if O took an edge in round 2, take center
        position = 4
      elsif (opponent & @center).size > 0  # if O took center in round 2, take opposite corner
        position = o_center(player)
      elsif (opponent & @corners).size > 0  # if O took a corner in round 2, figure out which one
        position = o_corner(player, opponent)
      end
    elsif round == 5
      if (opponent & @corners).size > 0  # if O took a corner in round 2, take the last available corner
        position = o_corner(player, opponent)
      end
    end
  end

  def get_move(game_board, round, mark, wins, x_pos, o_pos)
    if round <= 6  # changed from 4 to 6, may change again based on opening_x and opening_o
       mark == "X" ? position = opening_x(wins, x_pos, o_pos, round) : position = opening_o(round)
    else
      mark == "X" ? position = block(wins, x_pos, o_pos) : position = block(wins, o_pos, x_pos)
    end
    move = @moves[position]
  end

end

# Sandbox testing
board = Board.new
p1 = PlayerPerfect.new

# board.game_board = ["X", "", "", "", "O", "", "", "", ""]  # round 3 - b3
# board.game_board = ["", "", "X", "", "O", "", "", "", ""]  # round 3 - b1
# board.game_board = ["", "", "", "", "O", "", "X", "", ""]  # round 3 - t3
# board.game_board = ["", "", "", "", "O", "", "", "", "X"]  # round 3 - t1

# board.game_board = ["X", "", "", "O", "X", "", "", "", "O"]  # round 3 - t1
# board.game_board = ["O", "", "", "", "", "", "", "", "X"]  # round 3 - t1

# board.game_board = ["X", "", "O", "", "O", "", "", "", "X"]  # round 5 - O took corner, variation 1 (b1)
board.game_board = ["X", "O", "X", "", "", "", "", "", "O"]  # round 5 - O took corner, variation 2 (b1)

# board.game_board = ["X", "O", "", "", "O", "", "", "", "X"]  # round 5 - X blocks O at b2
# board.game_board = ["X", "", "", "O", "O", "", "", "", "X"]  # round 5 - X blocks O at m3
# board.game_board = ["X", "", "", "", "O", "O", "", "", "X"]  # round 5 - X blocks O at m1
# board.game_board = ["X", "", "", "", "O", "", "", "O", "X"]  # round 5 - X blocks O at t2

# board.game_board = ["X", "O", "", "", "O", "", "O", "X", "X"]  # round 7 - X blocks O at t3
# board.game_board = ["X", "", "O", "O", "O", "X", "", "", "X"]  # round 7 - X blocks O at b1
# board.game_board = ["", "", "X", "O", "O", "X", "X", "", "O"]  # round 7 - X blocks O at t1
# board.game_board = ["O", "", "X", "X", "O", "O", "X", "", ""]  # round 7 - X blocks O at b3
# board.game_board = ["O", "", "X", "", "O", "", "X", "O", ""]  # round 7 - X blocks O at t2

# board.game_board = ["X", "O", "X", "", "O", "", "O", "X", "X"]  # round 9 - X wins at m3
# board.game_board = ["X", "", "O", "O", "O", "X", "X", "", "X"]  # round 9 - X wins at b2
# board.game_board = ["X", "", "X", "X", "O", "O", "O", "", "X"]  # round 9 - X wins at t2
# board.game_board = ["X", "X", "O", "", "O", "", "X", "O", "X"]  # round 9 - X wins at m1

# board.game_board = ["O", "O", "", "X", "O", "X", "X", "", ""]   # X blocks O at t3, b2 or b3
# board.game_board = ["X", "X", "", "O", "X", "O", "O", "", ""]   # X wins at t3, b2 or b3
# board.game_board = ["X", "", "", "", "", "O", "O", "X", ""]   # variation 1 - X will take t2, t3, m1, m2 or b3
# board.game_board = ["O", "X", "", "", "X", "O", "", "O", "X"]   # variation 2 - X will take t3, m1 or b1

round = board.get_round(board.x_count, board.o_count)
mark = board.get_mark(board.x_count, board.o_count)
wins = board.wins
p "Round: #{round}"

x_pos = board.get_x
o_pos = board.get_o
puts p1.get_move(board.game_board, round, mark, wins, x_pos, o_pos)

# player = board.get_x
# opponent = board.get_o
# p p1.opening_x(wins, player, opponent, round)