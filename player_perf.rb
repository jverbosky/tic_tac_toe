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

  # Method to return position to block, last resort logic - take a random position
  def block(wins, player, opponent)
    position = []
    side_index = 0
    wins.each do |win|
      difference = win - opponent  # difference between current win array and opponent position array
      if difference.count == 1  # if opponent 1 move from win, block position unless already player mark
        position.push(difference[0]) unless (player & difference).count == 1
      end
    end
    if position.count == 0  # if nothing to block or win, use edge logic
      # identify side with adjacent marks (top = 0, right = 1, bottom = 2, right = 3)
      @sides.each_with_index { |side, s_index| side_index = s_index if ((player + opponent) & side).count > 1 }
      # determine empty (reference) corner in side with adjacent marks
      refcor = @sides[side_index] - ((player + opponent) & @sides[side_index])
      position.push(op_corner(refcor))  # figure out which corner is the opposite and take it
    end
    position.sample  # .sample in case of multiple
  end

  # Method to return position to win, call block if no wins
  def win_check(wins, player, opponent)
    position = []
    wins.each do |win|
      difference = win - player  # difference between current win array and player position array
      if difference.count == 1  # if player 1 move from win, take position unless already opponent mark
        position.push(difference[0]) unless (opponent & difference).count == 1
      end
    end
    position.count > 0 ? position.sample : block(wins, player, opponent)  # .sample in case of multiple
    # position.sample  # .sample in case of multiple
  end

  # Method to return the corner opposite the current corner
  def op_corner(corner)
    if (@opcor_1 - corner).size == 1
      position = (@opcor_1 - corner)[0]
    else
      position = (@opcor_2 - corner)[0]
    end
  end

  # Method to handle corner selection when O selects a corner in round 2
  def corner_logic(player, opponent)
    taken = player + opponent  # get corners to compare against opposite pairs
    if (taken - @opcor_1).size == 0 || (taken - @opcor_2).size == 0  # if opposing player & opponent corners, take an empty corner
      available = @corners - taken
      position = available.sample
    elsif (taken - @corners).size > 0  # if opponent has corner & non-corner, take last open corner
      intersection = taken & @corners  # determine which corners are taken
      position = (@corners - intersection)[0]
    else  # figure out which corner is opposite and take it
      position = op_corner(player)
    end
  end

  # Method to handle o logic for different rounds
  def move_o(round)
    # position = false
    # case round
    #   when 2 then position = 4  # take the center
    #   when 4 then position = [1, 3, 5, 7].sample  # take an edge
    # end
    # position
  end

  # Method to handle X logic for different rounds
  def move_x(wins, player, opponent, round)
    if round == 1
      position = [0, 2, 6, 8].sample  # take a corner, any corner
    elsif round == 3
      if (opponent & @edges).size > 0  # if O took an edge in round 2, take center
        position = 4
      elsif (opponent & @center).size > 0  # if O took center in round 2, take opposite corner
        position = op_corner (player)
      elsif (opponent & @corners).size > 0  # if O took a corner in round 2, figure out which one
        position = corner_logic(player, opponent)
      end
    elsif round == 5
      if (player & @corners).size == 2 && (opponent & @corners).size == 1  # if O took a corner in round 2
        position = corner_logic(player, opponent)  # take the last available corner
      elsif (player & @corners).size == 2 && (opponent & @corners).size == 0  # if O is perfect will have center + edge
        position = block(wins, player, opponent)  # so block at opposite edge
      else  # resort to win/block/edge logic
        position = win_check(wins, player, opponent)
      end
    else  # resort to win/block logic for rounds 7+
      position = win_check(wins, player, opponent)
    end
  end

  def get_move(game_board, round, mark, wins, x_pos, o_pos)
    mark == "X" ? position = move_x(wins, x_pos, o_pos, round) : position = move_o(round)
    move = @moves[position]
  end

end

#-----------------------------------------------------------------------------
# Sandbox testing
board = Board.new
p1 = PlayerPerfect.new
#-----------------------------------------------------------------------------
# Round 1 - X
#-----------------------------------------------------------------------------
# board.game_board = ["", "", "", "", "", "", "", "", ""]  # (t1/t3/b1/b3) 1
#-----------------------------------------------------------------------------
# Round 3 - X
#-----------------------------------------------------------------------------
# board.game_board = ["X", "", "", "", "O", "", "", "", ""]  # Perfect O - took center v1 (b3) 2
# board.game_board = ["", "", "X", "", "O", "", "", "", ""]  # Perfect O - took center v2 (b1) 3
# board.game_board = ["", "", "", "", "O", "", "X", "", ""]  # Perfect O - took center v3 (t3) 4
# board.game_board = ["", "", "", "", "O", "", "", "", "X"]  # Perfect O - took center v4 (t1) 5
#-----------------------------------------------------------------------------
# board.game_board = ["X", "", "", "", "", "", "", "O", ""]  # O took edge, X takes center (m2) 6
# board.game_board = ["X", "", "O", "", "", "", "", "", ""]  # O took corner, X takes op corner v1 (b3) 7
# board.game_board = ["O", "", "X", "", "", "", "", "", ""]  # O took corner, X takes op corner v2 (b1) 8
# board.game_board = ["X", "", "", "", "", "", "", "", "O"]  # O took op corner, X takes corner v1 (t3/b1) 9
# board.game_board = ["", "", "X", "", "", "", "O", "", ""]  # O took op corner, X takes corner v2 (t1/b3) 10
#-----------------------------------------------------------------------------
# Round 5 - X
#-----------------------------------------------------------------------------
# board.game_board = ["X", "O", "", "", "O", "", "", "", "X"]  # Perfect O - took edge v1, X blocks (b2) 11
# board.game_board = ["X", "", "", "O", "O", "", "", "", "X"]  # Perfect O - took edge v2, X blocks (m3) 12
# board.game_board = ["X", "", "", "", "O", "O", "", "", "X"]  # Perfect O - took edge v3, X blocks (m1) 13
# board.game_board = ["X", "", "", "", "O", "", "", "O", "X"]  # Perfect O - took edge v4, X blocks (t2) 14
#-----------------------------------------------------------------------------
# board.game_board = ["X", "", "O", "", "O", "", "", "", "X"]  # O took center after corner, X block & sets 2 wins (b1) 15
# board.game_board = ["X", "O", "X", "", "", "", "", "", "O"]  # O took edge after op corner, X sets 2 wins (b1) 16
# board.game_board = ["X", "", "", "", "O", "", "O", "", "X"]  # O took corner after center, X block & sets 2 wins (t3) 17
# board.game_board = ["X", "O", "", "", "X", "", "", "", "O"]  # O took corner after edge v1, X sets 2 wins (b1) 18
# board.game_board = ["X", "", "", "O", "X", "", "", "", "O"]  # O took corner after edge v2, X sets 2 wins (t3) 19
# board.game_board = ["X", "", "", "", "X", "O", "", "", "O"]  # O took corner after edge v3, X block & sets 2 wins (t3) 20
# board.game_board = ["X", "", "", "", "X", "", "", "O", "O"]  # O took corner after edge v4, X block & sets 2 wins (b1) 21
#-----------------------------------------------------------------------------
# board.game_board = ["X", "", "X", "", "", "", "O", "", "O"]  # added failsafe logic to move_x() round 5 (t2) 22
# board.game_board = ["", "", "O", "O", "X", "", "", "", "X"]  # merged edge_logic() into block() (t1) 23
# board.game_board = ["X", "", "O", "O", "X", "", "", "", ""]  # merged edge_logic() into block() (b3) 24
#-----------------------------------------------------------------------------
# Round 7 - X
#-----------------------------------------------------------------------------
# board.game_board = ["X", "", "O", "O", "O", "", "X", "", "X"]  # O blocks at m1, X wins (b2) 25
# board.game_board = ["X", "", "O", "", "O", "", "X", "O", "X"]  # O blocks at b2, X wins (m1) 26
# board.game_board = ["X", "O", "X", "O", "", "", "X", "", "O"]  # O blocks at m1, X wins (m2) 27
# board.game_board = ["X", "O", "X", "", "O", "", "X", "", "O"]  # O blocks at m2, X wins (m1) 28
# board.game_board = ["X", "O", "X", "", "O", "", "O", "", "X"]  # O blocks at t2, X wins (m3) 29
# board.game_board = ["X", "", "X", "", "O", "O", "O", "", "X"]  # O blocks at m3, X wins (t2) 30
# board.game_board = ["X", "O", "O", "", "X", "", "X", "", "O"]  # O blocks at t3, X wins (m1) 31
# board.game_board = ["X", "O", "", "O", "X", "", "X", "", "O"]  # O blocks at m1, X wins (t3) 32
# board.game_board = ["X", "O", "X", "O", "X", "", "", "", "O"]  # O blocks at t2, X wins (b1) 33
# board.game_board = ["X", "", "X", "O", "X", "", "O", "", "O"]  # O blocks at b1, X wins (t2) 34
# board.game_board = ["X", "O", "X", "", "X", "O", "", "", "O"]  # O blocks at t2, X wins (b1) 35
# board.game_board = ["X", "", "X", "", "X", "O", "O", "", "O"]  # O blocks at b1, X wins (t2) 36
# board.game_board = ["X", "", "O", "", "X", "", "X", "O", "O"]  # O blocks at t3, X wins (m1) 37
# board.game_board = ["X", "", "", "O", "X", "", "X", "O", "O"]  # O blocks at m1, X wins (t3) 38
# board.game_board = ["X", "O", "", "", "O", "", "O", "X", "X"]  # X blocks O v1 (t3) 39
# board.game_board = ["X", "", "O", "O", "O", "X", "", "", "X"]  # X blocks O v2 (b1) 40
# board.game_board = ["", "", "X", "O", "O", "X", "X", "", "O"]  # X blocks O v3 (t1) 41
# board.game_board = ["O", "", "X", "X", "O", "O", "X", "", ""]  # X blocks O v4 (b3) 42
#-----------------------------------------------------------------------------
# - multiple selection tests
#-----------------------------------------------------------------------------
# board.game_board = ["O", "O", "", "X", "O", "X", "X", "", ""]   # multiple X blocks O (t3/b2/b3) 43
# board.game_board = ["X", "X", "", "O", "X", "O", "O", "", ""]   # multiple X wins (t3/b2/b3) 44
#-----------------------------------------------------------------------------
# Round 8 - O
#-----------------------------------------------------------------------------
# board.game_board = ["X", "O", "X", "", "O", "", "O", "X", "X"]  # round 9 - X wins v1 (m3) 45
# board.game_board = ["X", "", "O", "O", "O", "X", "X", "", "X"]  # round 9 - X wins v2 (b2) 46
# board.game_board = ["X", "", "X", "X", "O", "O", "O", "", "X"]  # round 9 - X wins v3 (t2) 47
# board.game_board = ["X", "X", "O", "", "O", "", "X", "O", "X"]  # round 9 - X wins v4 (m1) 48
#-----------------------------------------------------------------------------
# Round 9 - X
#-----------------------------------------------------------------------------
# board.game_board = ["X", "O", "X", "", "O", "O", "O", "X", "X"]  # X ties v1 (m1)
# board.game_board = ["X", "", "O", "O", "O", "X", "X", "O", "X"]  # X ties v2 (t2)
# board.game_board = ["X", "O", "X", "O", "O", "X", "X", "", "O"]  # X ties v3 (b2)
# board.game_board = ["O", "", "X", "X", "O", "O", "X", "O", "X"]  # X ties v4 (t2)
#-----------------------------------------------------------------------------
round = board.get_round(board.x_count, board.o_count)
p "Round: #{round}"
mark = board.get_mark(board.x_count, board.o_count)
wins = board.wins
x_pos = board.get_x
o_pos = board.get_o
puts p1.get_move(board.game_board, round, mark, wins, x_pos, o_pos)
#-----------------------------------------------------------------------------
# player = board.get_x
# opponent = board.get_o
# p p1.opening_x(wins, player, opponent, round)
#-----------------------------------------------------------------------------