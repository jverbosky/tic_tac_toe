require_relative "board.rb"

# class for computer player that plays perfectly to a win or a tie
class PlayerPerfect

  def initialize
    @moves = ["t1", "t2", "t3", "m1", "m2", "m3", "b1", "b2", "b3"]
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
    # changing block so it doesn't automatically call move() - needed by o_edge() without call to win
    # need to adjust previous logic in get_move() to call move() if block returns false
    # position.count > 0 ? position.sample : move(wins, player, opponent)  # .sample in case of multiple
    position.count > 0 ? position.sample : false  # added for using with o_edge(), may need to expand
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
    # if not, figure out which corner is the opposite and take it
    elsif (@opcor_1 - player).size == 1
      position = (@opcor_1 - player)[0]
    else
      position = (@opcor_2 - player)[0]
    end
  end

#-----------------------------------------------------------------------------
# Edge
# - O takes an edge in round 1, has to block with a corner in round 3
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

  # Method to handle X logic for round 5 when O took an edge in round 2
  def o_edge(wins, player, opponent)
    win_test = block(wins, player, opponent)
    puts "Block: #{win_test}"
    unless win_test == false
      position = win_test
    else
      puts "logic to pick ideal edge"
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
      puts "Breaking here"
      puts "Opponent: #{opponent}"
      puts "Player: #{player}"
      puts "Corners: #{@corners}"
      if ((player + opponent) & @corners).size == 3  # if O took a corner in round 2, take the last available corner
        puts "O took a corner in round 2"
        position = o_corner(player, opponent)
      elsif ((player + opponent) & @corners).size == 2  # if O took an edge in round 2, take a specific corner
        puts "O took edge in round 2"
        position = o_edge(wins, player, opponent)
      else
        puts "None of the other conditions selected"
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

# board.game_board = ["X", "", "", "", "O", "", "", "", ""]  # round 3 - perfect player v1 (b3)
# board.game_board = ["", "", "X", "", "O", "", "", "", ""]  # round 3 - perfect player v2 (b1)
# board.game_board = ["", "", "", "", "O", "", "X", "", ""]  # round 3 - perfect player v3 (t3)
# board.game_board = ["", "", "", "", "O", "", "", "", "X"]  # round 3 - perfect player v4 (t1)

# board.game_board = ["X", "", "", "", "", "", "", "O", ""]  # round 3 - O took edge, take center (m2)
# board.game_board = ["X", "", "", "", "O", "", "", "", ""]  # round 3 - O took center, take op corner v1 (b3)
# board.game_board = ["", "", "X", "", "O", "", "", "", ""]  # round 3 - O took center, take op corner v2 (b1)
# board.game_board = ["X", "", "O", "", "", "", "", "", ""]  # round 3 - O took corner, take op corner v1 (b3)
# board.game_board = ["O", "", "X", "", "", "", "", "", ""]  # round 3 - O took corner, take op corner v2 (b1)
# board.game_board = ["X", "", "", "", "", "", "", "", "O"]  # round 3 - O took op corner, take corner v1 (t3/b1)
# board.game_board = ["", "", "X", "", "", "", "O", "", ""]  # round 3 - O took corner, take op corner v2 (t1/b3)

# board.game_board = ["X", "", "O", "", "O", "", "", "", "X"]  # round 5 - O took center after corner (b1)
# board.game_board = ["X", "O", "X", "", "", "", "", "", "O"]  # round 5 - O took edge after op corner (b1)
# board.game_board = ["X", "", "", "", "O", "", "O", "", "X"]  # round 5 - O took corner after center (t3)

# board.game_board = ["X", "O", "", "", "X", "", "", "", "O"]  # round 5 - O took corner after edge v1 (b1)
board.game_board = ["X", "", "", "O", "X", "", "", "", "O"]  # round 5 - O took corner after edge v2 (t3)
# board.game_board = ["X", "", "", "", "X", "O", "", "", "O"]  # round 5 - O took corner after edge v3 (block - t3)
# board.game_board = ["X", "", "", "", "X", "", "", "O", "O"]  # round 5 - O took corner after edge v4 (block - b1)

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