require_relative "board.rb"

# class for computer player that plays perfectly to a win or a tie
class PlayerPerfect

  def initialize
    @moves = ["t1", "t2", "t3", "m1", "m2", "m3", "b1", "b2", "b3"]
    @sides = [[0, 1, 2], [2, 5, 8], [6, 7, 8], [0, 3, 6]]
    @corners = [0, 2, 6, 8]
    @opcor_1 = [0, 8]  # opposite corners set 1
    @opcor_2 = [2, 6]  # opposite corners set 2
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

#-----------------------------------------------------------------------------
# Corner Logic
#-----------------------------------------------------------------------------
# Variation 1:
# - O takes non-opposite corner in round 2, forced to block in middle in round 4
# - X takes last open corner in round 5 for two paths to win
#
#   X - -     X - O     X - O     X - O     X - O
#   - - -  >  - - -  >  - - -  >  - O -  >  - O -
#   - - -     - - -     - - X     - - X     X - X
#-----------------------------------------------------------------------------
# Variation 2:
# - O takes opposite corner in round 2, forced to block on edge in round 4
# - X takes last open corner in round 5 for two paths to win
#
#   X - -     X - -     X - X     X O X     X O X
#   - - -  >  - - -  >  - - -  >  - - -  >  - - -
#   - - -     - - O     - - O     - - O     X - O
#-----------------------------------------------------------------------------
# Variation 3: O takes center in round 2, then takes an open corner in round 4
# - X takes last open corner in round 5 for two paths to win
#
#   X - -     X - -     X - -     X - -     X - X
#   - - -  >  - O -  >  - O -  >  - O -  >  - O -
#   - - -     - - -     - - X     O - X     O - X
#-----------------------------------------------------------------------------

  # Method to return the corner opposite the current corner
  def op_corner(corner)
    if (@opcor_1 - corner).size == 1
      position = (@opcor_1 - corner)[0]
    else
      position = (@opcor_2 - corner)[0]
    end
  end

  # Method to handle corner selection when O selects a corner in round 2
  def o_corner(player, opponent)
    taken = player + opponent  # get corners to compare against opposite pairs
    # if player & opponent corners are opposite, take an empty corner
    if (taken - @opcor_1).size == 0 || (taken - @opcor_2).size == 0
      available = @corners - taken
      position = available.sample
    # round 5 - if opponent has corner & non-corner positions, take last open corner
    elsif (taken - @corners).size > 0
      intersection = taken & @corners  # determine which corners are taken
      position = (@corners - intersection)[0]
    # if not, figure out which corner is opposite and take it
    else
      position = op_corner(player)
    end
  end

#-----------------------------------------------------------------------------
# Edge Logic
#-----------------------------------------------------------------------------
# - O takes an edge in round 2, has to block with a corner in round 4
# - X takes a specific corner for two paths to win
# - Need to consider non-winning and winning variations
#-----------------------------------------------------------------------------
# Variation 1:
# - Non-winning O edge top (example)
#
#   X - -     X O -     X O -     X O -     X O -
#   - - -  >  - - -  >  - X -  >  - X -  >  - X -
#   - - -     - - -     - - -     - - O     X - O
#-----------------------------------------------------------------------------
# Variation 2:
# - Non-winning O edge middle (example)
#
#   X - -     X - -     X - -     X - -     X - X
#   - - -  >  O - -  >  O X -  >  O X -  >  O X -
#   - - -     - - -     - - -     - - O     - - O
#-----------------------------------------------------------------------------
# Variation 3:
# - Winning O edge middle (example)
#
#   X - -     X - -     X - -     X - -     X - X
#   - - -  >  - - O  >  - X O  >  - X O  >  - X O
#   - - -     - - -     - - -     - - O     - - O
#-----------------------------------------------------------------------------
# Variation 4:
# - Winning O edge bottom (example)
#
#   X - -     X - -     X - -     X - -     X - -
#   - - -  >  - - -  >  - X -  >  - X -  >  - X -
#   - - -     - O -     - O -     - O O     X O O
#-----------------------------------------------------------------------------

  # Method to handle X corner selection logic for round 5 when O took an edge in round 2
  def o_edge(wins, player, opponent)
    adjacent_o = 0
    side_index = 0
    @sides.each { |side| adjacent_o += 1 if (side & opponent).count == 2 }
    if adjacent_o == 1
      position = block(wins, player, opponent)
    else
      # identify side with adjacent marks (top = 0, right = 1, bottom = 2, right = 3)
      @sides.each_with_index { |side, s_index| side_index = s_index if ((player + opponent) & side).count > 1 }
      # determine empty (reference) corner in side with adjacent marks
      refcor = @sides[side_index] - ((player + opponent) & @sides[side_index])
      # figure out which corner is the opposite and take it
      position = op_corner(refcor)
    end
  end

  # Method to handle X logic for opening rounds
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
      if ((player + opponent) & @corners).size == 3  # if O took a corner in round 2, take the last available corner
        position = o_corner(player, opponent)
      elsif ((player + opponent) & @corners).size == 2  # if O took an edge in round 2, take a specific corner
        position = o_edge(wins, player, opponent)
      end
    end
  end

  def get_move(game_board, round, mark, wins, x_pos, o_pos)
    if round <= 6  # changed from 4 to 6, may change again based on opening_x and opening_o
       mark == "X" ? position = opening_x(wins, x_pos, o_pos, round) : position = opening_o(round)
    # knocking next two lines out to isolate if statement
    # else
    #   mark == "X" ? position = block(wins, x_pos, o_pos) : position = block(wins, o_pos, x_pos)
    end
    move = @moves[position]
  end

end

# Sandbox testing
board = Board.new
p1 = PlayerPerfect.new

#-----------------------------------------------------------------------------
# Round 1 - X
#-----------------------------------------------------------------------------
# board.game_board = ["", "", "", "", "", "", "", "", ""]  # (t1/t3/b1/b3)
#-----------------------------------------------------------------------------
# Round 3 - X
#-----------------------------------------------------------------------------
# board.game_board = ["X", "", "", "", "O", "", "", "", ""]  # Perfect O - took center v1 (b3)
# board.game_board = ["", "", "X", "", "O", "", "", "", ""]  # Perfect O - took center v2 (b1)
# board.game_board = ["", "", "", "", "O", "", "X", "", ""]  # Perfect O - took center v3 (t3)
# board.game_board = ["", "", "", "", "O", "", "", "", "X"]  # Perfect O - took center v4 (t1)
#-----------------------------------------------------------------------------
# board.game_board = ["X", "", "", "", "", "", "", "O", ""]  # O took edge, X takes center (m2)
# board.game_board = ["X", "", "", "", "O", "", "", "", ""]  # O took center, X takes op corner v1 (b3)
# board.game_board = ["", "", "X", "", "O", "", "", "", ""]  # O took center, X takes op corner v2 (b1)
# board.game_board = ["X", "", "O", "", "", "", "", "", ""]  # O took corner, X takes op corner v1 (b3)
# board.game_board = ["O", "", "X", "", "", "", "", "", ""]  # O took corner, X takes op corner v2 (b1)
# board.game_board = ["X", "", "", "", "", "", "", "", "O"]  # O took op corner, X takes corner v1 (t3/b1)
# board.game_board = ["", "", "X", "", "", "", "O", "", ""]  # O took op corner, X takes corner v2 (t1/b3)
#-----------------------------------------------------------------------------
# Round 5 - X
#-----------------------------------------------------------------------------
# board.game_board = ["X", "O", "", "", "O", "", "", "", "X"]  # Perfect O - took edge, X blocks (b2) * broke - now b1 
# board.game_board = ["X", "", "", "O", "O", "", "", "", "X"]  # Perfect O - took edge, X blocks (m3) * broke - now t3 
# board.game_board = ["X", "", "", "", "O", "O", "", "", "X"]  # Perfect O - took edge, X blocks (m1) * broke - now b1 
# board.game_board = ["X", "", "", "", "O", "", "", "O", "X"]  # Perfect O - took edge, X blocks (t2) * broek - now t3 
#-----------------------------------------------------------------------------
# board.game_board = ["X", "", "O", "", "O", "", "", "", "X"]  # O took center after corner, X block & sets 2 wins (b1)
# board.game_board = ["X", "O", "X", "", "", "", "", "", "O"]  # O took edge after op corner, X setup 2 wins (b1)
# board.game_board = ["X", "", "", "", "O", "", "O", "", "X"]  # O took corner after center, X block & sets 2 wins (t3)
# board.game_board = ["X", "O", "", "", "X", "", "", "", "O"]  # O took corner after edge v1, X sets 2 wins (b1)
# board.game_board = ["X", "", "", "O", "X", "", "", "", "O"]  # O took corner after edge v2, X sets 2 wins (t3)
# board.game_board = ["X", "", "", "", "X", "O", "", "", "O"]  # O took corner after edge v3, X block & sets 2 wins (t3)
# board.game_board = ["X", "", "", "", "X", "", "", "O", "O"]  # O took corner after edge v4, X block & sets 2 wins (b1)
#-----------------------------------------------------------------------------
# 1) Need to re-test previous tests and verify still true - found 4 that broke in round 5
# 2) Review get_move() - may not want "round <= 6" logic
# 3) Review wikipedia - any more non-perfect O moves unaccounted for? (round 5+)
#    - Or will block() and move() handle remaining board variations for X?

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