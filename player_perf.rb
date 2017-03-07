require_relative "board.rb"

# class for computer player that plays perfectly to a win or a tie
class PlayerPerfect

  def initialize
    @moves = ["t1", "t2", "t3", "m1", "m2", "m3", "b1", "b2", "b3"]  # "human friendly" board positions
    @sides = [[0, 1, 2], [2, 5, 8], [6, 7, 8], [0, 3, 6]]  # sides (top, right, bottom, left)
    @corners = [0, 2, 6, 8]  # corner positions
    @opcor_1 = [0, 8]  # opposite corners - set 1
    @opcor_2 = [2, 6]  # opposite corners - set 2
    @edges = [1, 3, 5, 7]  # edge positions
    @opedg_1 = [1, 7]  # opposite edges - set 1
    @opedg_2 = [3, 5]  # opposite edges - set 2
    @adjedg = [[5, 7], [3, 7], [1, 5], [1, 3]]  # adjacent edges (order vital for opposite corner comparison)
    @center = [4]  # center position
  end

  # Method to retrieve optimal position and convert it to a "human friendly" board position
  def get_move(game_board, round, mark, wins, x_pos, o_pos)
    # Use current mark (X/O) to determine  current player, then call appropriate method to get position
    mark == "X" ? position = move_x(wins, x_pos, o_pos, round) : position = move_o(wins, o_pos, x_pos, round)
    # Translate the position's array index to a "human friendly" borad position and return it
    move = @moves[position]
  end

  # Method to handle X logic for different rounds
  def move_x(wins, player, opponent, round)
    if round == 1  # in round 1
      position = @corners.sample  # take a corner, any corner
    elsif round == 3  # in round 3
      position = move_r3(player, opponent)  # determine ideal position based on O's position
    elsif round == 5  # in round 5
      position = move_r5(wins, player, opponent)  # determine ideal position based on O's positions
    else  # in remaining rounds
      position = win_check(wins, player, opponent)  # use win/block logic
    end
  end

  # Method to handle O logic for different rounds
  def move_o(wins, player, opponent, round)
    if round == 2  # in round 2
      # check if X took center and if so take a corner, otherwise take center
      (opponent & @center).size == 1 ? position = @corners.sample : position = 4
    elsif round == 4  # in round 4
      position = move_r4(wins, player, opponent)  # determine ideal position based on X and O's positions
    elsif round == 6  # in round 6
      position = move_r6(wins, player, opponent)  # determine ideal position based on X and O's positions
    else
      position = move_r8(wins, player, opponent)  # determine ideal position based on X and O's positions
    end
  end

  # Method to handle logic based on move O made in round 2
  def move_r3(player, opponent)
    if (opponent & @edges).size > 0  # if O took an edge
      position = 4  # then take center
    elsif (opponent & @center).size > 0  # if O took center
      position = op_corner(player)  # the take the opposite corner
    elsif (opponent & @corners).size > 0  # if O took a corner, need to figure out which one
      position = corner_logic(player, opponent)  # use corner_logic() to take the appropriate corner
    end
  end

  # Method to handle logic based on player positions in round 4
  def move_r4(wins, player, opponent)
    taken = player + opponent  # all occupied board positions
    if (opponent & @opcor_1).size == 2 || (opponent & @opcor_2).size == 2  # if X took opposite corners
      position = @edges.sample  # take an edge, any edge
    elsif (opponent & @opedg_1).size == 2 || (opponent & @opedg_2).size == 2  # if X took opposite edges
      position = @corners.sample  # take a corner, any corner
    elsif (opponent & @edges).size == 2  # if X took adjacent edges (already filtered opposite edges)
      position = adj_edge(player, opponent)  # return corner between adjacent edges
    elsif (taken & (@opcor_1 + @center)).size == 3 || (taken & (@opcor_2 + @center)).size == 3  # if X+O have opcor pair and corner
      position = avail_corner(player, opponent)  # return random open corner
    elsif (opponent & @edges).size == 1 && (opponent & @corners).size == 1  # if X has one edge and one corner
      position = edgcor_logic(wins, player, opponent)  # return a random edge or block based on relative locations
    else
      position = block(wins, player, opponent)  # otherwise block at edge
    end
  end

  # Method to handle logic based on player positions in round 5
  def move_r5(wins, player, opponent)
    if (player & @corners).size == 2 && (opponent & @corners).size == 1  # if O took a corner in round 2
      position = corner_logic(player, opponent)  # take the last available corner
    elsif (player & @corners).size == 2 && (opponent & @corners).size == 0  # if O is perfect, will have center+edge
      position = block(wins, player, opponent)  # so block at opposite edge
    else
      position = win_check(wins, player, opponent)  # otherwise use win/block/edge logic
    end
  end

  # Method to handle logic based on player positions in round 6
  def move_r6(wins, player, opponent)
    opponent_corners = opponent & @corners  # corners taken by opponent
    opponent_edges = opponent & @edges  # edges taken by opponent
    taken = player + opponent  # all occupied board positions
    taken_edges = taken & @edges  # all occupied edges
    taken_corners = taken & @corners  # all occupied corners
    c_side = 7  # @sides index of side with two corners (placeholder value to avoid false positives)
    e_side = 7  # @sides index of side with one edge (placeholder value to avoid false positives)
    c_index = 11  # index of @corners (placeholder value to avoid false positives)
    e_index = 17  # index of @adjedg pair (placeholder value to avoid false positives)
    # Collect indexes of sides where opponent has two corners and opponent has one edge
    @sides.each_with_index { |side, s_index| c_side = s_index if (side & opponent_corners).size == 2 }
    @sides.each_with_index { |side, s_index| e_side = s_index if (side & opponent_edges).size == 1 }
    # Collect indexes of opponent's adjacent edge pair and corner
    @corners.each_with_index { |corner, cor_index| c_index = cor_index if opponent.include? corner }
    @adjedg.each_with_index { |e_pair, adj_index| e_index = adj_index if (opponent & e_pair).size == 2 }
    if (c_side - e_side).abs == 2  # if side indexes are off by two, they oppose
      position = (@edges - taken_edges).sample  # so take random open edge
    elsif e_index == c_index  # if index of adjacent edges and corner match, they oppose
      position = (@corners - taken_corners).sample  # so take random open corner
    else
      position = win_check(wins, player, opponent)  # otherwise use win/block/edge logic
    end
  end

  # Method to handle logic based on player positions in round 8
  def move_r8(wins, player, opponent)
    position = win_check(wins, player, opponent)  # otherwise use win/block/edge logic
  end

  # Method to return the corner opposite the current corner
  def op_corner(corner)
    if (@opcor_1 - corner).size == 1  # if @opcor_1 and corner differ by 1
      position = (@opcor_1 - corner)[0]  # then the opposite corner is the other element in @opcor_1
    else
      position = (@opcor_2 - corner)[0]  # otherwise the opposite corner is the other element in @opcor_2
    end
  end

  # Method to return corner in between adjacent edges
  def adj_edge(player, opponent)
    target = []  # array to hold positions of sides that do not contain opponent corner
    @sides.each { |side| target += side if (opponent & side).size > 0 }  # collect positions of sides that contain X
    position = target.detect{ |value| target.count(value) > 1 }  # then return corner that appears twice
  end

  # Method to handle corner selection when O has selected a corner in round 2
  def corner_logic(player, opponent)
    taken = player + opponent  # all occupied board positions
    if (taken - @opcor_1).size == 0 || (taken - @opcor_2).size == 0  # if player/opponent are at opposing corners
      available = @corners - taken  # determine with corners are available
      position = available.sample  # then randomly choose one of the corners from the available array
    elsif (taken - @corners).size > 0  # round 5 - if opponent has corner & non-corner
      intersection = taken & @corners  # determine which corners are taken
      position = (@corners - intersection)[0]  # then take the last open corner
    else
      position = op_corner(player)  # otherwise figure out which corner is opposite and take it
    end
  end

  # Method to return random open corner when player and opponent occupy one pair of opposing corners
  def avail_corner(player, opponent)
    taken = player + opponent  # all occupied board positions
    if (taken & @opcor_1).size == 2  # determine which corners are taken
      position = @opcor_2.sample  # take random corner from this opcor pair
    else
      position = @opcor_1.sample  # or this opcor pair
    end
  end

  # Method to return corner opposite to O when O has corner and non-adjacent edge
  def edge_logic(player, opponent)
    all = @corners + @edges + @center  # all board positions
    taken = player + opponent  # all occupied board positions
    if taken.count < 7  # if called in a round lower than 8
      side_index = 0  # array index for sides (clockwise: top = 0, right = 1, bottom = 2, right = 3)
      # get array index of the side with adjacent player and opponent marks
      @sides.each_with_index { |side, s_index| side_index = s_index if (taken & side).size > 1 }
      # determine empty corner in side with adjacent player and opponent marks
      refcor = @sides[side_index] - (taken & @sides[side_index])
      position = op_corner(refcor)  # take corner that is opposite the reference corner
    else  # otherwise take one of the (or the very) last position
      position = (all - taken).sample  # take a random position
    end
  end

  # Method to handle logic when X has one edge and one corner in round 4
  def edgcor_logic(wins, player, opponent)
    adjacent = false  # use to determine adjacency
    @sides.each { |side| adjacent = true if (opponent & side).count > 1 }  # check if edge and corner are adjacent
    if adjacent == false  # if edge and corner not adjacent, take edge opposite opponent corner
      corner = @corners & opponent  # position of opponent corner
      edge = @edges & opponent  # position of opponent edge
      target = []  # array to hold positions of sides that do not contain opponent corner
      # collect positions of edges from sides without opponent corner
      @sides.each { |side| target += (side & @edges) if (corner & side).size == 0 }
      position = (target - edge)[0]  # take open edge
    else
      position = block(wins, player, opponent)  # otherwise edge and corner are adjacent, so block at corner
    end
  end

  # Method to return position to block, call edge_logic() if no blocks
  def block(wins, player, opponent)
    position = []  # placeholder for position that will block the opponent
    wins.each do |win|  # check each win pattern
      difference = win - opponent  # difference between current win array and opponent position array
      if difference.count == 1  # if opponent 1 move from win, block position unless already player mark
        position.push(difference[0]) unless (player & difference).count == 1
      end
    end
    position.count > 0 ? position.sample : edge_logic(player, opponent)  # .sample in case of multiple
  end

  # Method to return position to win, call block() if no wins
  def win_check(wins, player, opponent)
    position = []  # placeholder for position that will give 3-in-a-row
    wins.each do |win|  # check each win pattern
      difference = win - player  # difference between current win array and player position array
      if difference.count == 1  # if player 1 move from win, take position unless already opponent mark
        position.push(difference[0]) unless (opponent & difference).count == 1
      end
    end
    position.count > 0 ? position.sample : block(wins, player, opponent)  # .sample in case of multiple
  end

end

#-----------------------------------------------------------------------------
# Sandbox testing
board = Board.new
p1 = PlayerPerfect.new
#-----------------------------------------------------------------------------
# Round 1 - X
#-----------------------------------------------------------------------------
# board.game_board = ["", "", "", "", "", "", "", "", ""]  # X takes a random corner (t1/t3/b1/b3) 1
#-----------------------------------------------------------------------------
# Round 2 - O
#-----------------------------------------------------------------------------
# board.game_board = ["X", "", "", "", "", "", "", "", ""]  # O takes center (m2) 49
#-----------------------------------------------------------------------------
# board.game_board = ["", "", "", "", "X", "", "", "", ""]  # X took center, O takes a random corner (t1/t3/b1/b3) 60
# board.game_board = ["", "X", "", "", "", "", "", "", ""]  # X took edge, O takes center v1 (m2) 61
# board.game_board = ["", "", "", "X", "", "", "", "", ""]  # X took edge, O takes center v2 (m2) 62
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
# Round 4 - O
#-----------------------------------------------------------------------------
# board.game_board = ["X", "", "", "", "O", "", "", "", "X"]  # Perfect X - took opposite corner v1 (t2/m1/m3/b2) 50
# board.game_board = ["", "", "X", "", "O", "", "X", "", ""]  # Perfect X - took opposite corner v2 (t2/m1/m3/b2) 51
#-----------------------------------------------------------------------------
# board.game_board = ["X", "", "X", "", "O", "", "", "", ""]  # X took corner and adjacent corner, O blocks at edge v1 (t2) 63
# board.game_board = ["", "", "X", "", "O", "", "", "", "X"]  # X took corner and adjacent corner, O blocks at edge v2 (m3) 64
# board.game_board = ["X", "X", "", "", "O", "", "", "", ""]  # X took corner and adjacent edge, O blocks at adjacent corner v1 (t3) 65
# board.game_board = ["", "", "X", "", "O", "X", "", "", ""]  # X took corner and adjacent edge, O blocks at adjacent corner v2 (b3) 66
# board.game_board = ["X", "", "", "", "O", "", "", "X", ""]  # X took corner and non-adjacent edge, O takes edge opposite corner v1 (m3) 67
# board.game_board = ["X", "", "", "", "O", "X", "", "", ""]  # X took corner and non-adjacent edge, O takes edge opposite corner v2 (b2) 68
# board.game_board = ["O", "", "X", "", "X", "", "", "", ""]  # X took center and corner, O blocks at opposite corner v1 (b1) 69
# board.game_board = ["", "", "O", "", "X", "", "", "", "X"]  # X took center and corner, O blocks at opposite corner v2 (t1) 70
# board.game_board = ["O", "", "", "", "X", "", "", "", "X"]  # X took center and corner opposite O, O takes corner v1 (t3/b1) 71
# board.game_board = ["", "", "X", "", "X", "", "O", "", ""]  # X took center and corner opposite O, O takes corner v2 (t1/b3) 72
# board.game_board = ["O", "", "", "X", "X", "", "", "", ""]  # X took center and edge, O blocks at opposite edge v1 (m3) 73
# board.game_board = ["", "X", "O", "", "X", "", "", "", ""]  # X took center and edge, O blocks at opposite edge v2 (b2) 74
# board.game_board = ["", "X", "", "", "O", "", "", "X", ""]  # X took edge and opposite edge, O takes corner v1 (t1/t3/b1/b3) 75
# board.game_board = ["", "", "", "X", "O", "X", "", "", ""]  # X took edge and opposite edge, O takes corner v2 (t1/t3/b1/b3) 76
# board.game_board = ["", "X", "", "", "O", "X", "", "", ""]  # X took edge and adjacent edge, O takes corner between X v1 (t3) 77
# board.game_board = ["", "", "", "", "O", "X", "", "X", ""]  # X took edge and adjacent edge, O takes corner between X v2 (b3) 78
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
# board.game_board = ["X", "O", "", "", "X", "", "", "", "O"]  # O took opposite corner and non-adjacent edge v1, X sets 2 wins (b1) 18
# board.game_board = ["X", "", "", "O", "X", "", "", "", "O"]  # O took opposite corner and non-adjacent edge v2, X sets 2 wins (t3) 19
# board.game_board = ["X", "", "", "", "X", "O", "", "", "O"]  # O took opposite corner and adjacent edge v1, X block & sets 2 wins (t3) 20
# board.game_board = ["X", "", "", "", "X", "", "", "O", "O"]  # O took took opposite corner and adjacent edge v2, X block & sets 2 wins (b1) 21
#-----------------------------------------------------------------------------
# board.game_board = ["X", "", "X", "", "", "", "O", "", "O"]  # added failsafe logic to move_x() round 5 (t2) 22
# board.game_board = ["", "", "O", "O", "X", "", "", "", "X"]  # merged edge_logic() into block() (t1) 23
# board.game_board = ["X", "", "O", "O", "X", "", "", "", ""]  # merged edge_logic() into block() (b3) 24
#-----------------------------------------------------------------------------
# Round 6 - O
#-----------------------------------------------------------------------------
# board.game_board = ["X", "O", "", "", "O", "", "", "X", "X"]  # Perfect X - blocks at edge, O blocks at corner v1 (b1) 52
# board.game_board = ["X", "X", "", "", "O", "", "", "O", "X"]  # Perfect X - blocks at edge, O blocks at corner v2 (t3) 53
# board.game_board = ["", "", "X", "O", "O", "X", "X", "", ""]  # Perfect X - blocks at edge, O blocks at corner v3 (b3) 54
# board.game_board = ["", "", "X", "X", "O", "O", "X", "", ""]  # Perfect X - blocks at edge, O blocks at corner v4 (t1) 55
#-----------------------------------------------------------------------------
# board.game_board = ["X", "O", "X", "", "O", "", "", "X", ""]  # X took adjacent corners and opposite edges, O takes open edge v1 (m1/m3) 79
# board.game_board = ["", "", "X", "X", "O", "O", "", "", "X"]  # X took adjacent corners and opposite edges, O takes open edge v2 (t2/b2) 80
# board.game_board = ["X", "X", "O", "", "O", "", "X", "", ""]  # X took corner, adjacent edge and adjacent corner, O blocks at edge v1 (m1) 81
# board.game_board = ["X", "", "X", "", "O", "X", "", "", "O"]  # X took corner, adjacent edge and adjacent corner, O blocks at edge v2 (t2) 82
# board.game_board = ["X", "", "", "X", "O", "O", "", "X", ""]  # X took adjacent edges and adjacent corner, O blocks at corner v1 (b1) 83
# board.game_board = ["X", "X", "", "", "O", "X", "", "O", ""]  # X took adjacent edges and adjacent corner, O blocks at corner v2 (t3) 84
# board.game_board = ["O", "", "X", "X", "X", "", "O", "", ""]  # X took corner, center and opposite edge, O blocks at edge v1 (m3) 85
# board.game_board = ["O", "X", "O", "", "X", "", "X", "", ""]  # X took corner, center and opposite edge, O blocks at edge v2 (b2) 86
# board.game_board = ["O", "X", "", "X", "X", "O", "", "", ""]  # X took corner and adjacent edges, O blocks at edge v1 (b2) 87
# board.game_board = ["O", "X", "", "X", "X", "", "", "O", ""]  # X took corner and adjacent edges, O blocks at edge v2 (m3) 88
# board.game_board = ["O", "", "", "X", "X", "O", "X", "", ""]  # X took edge, adjacent corner and center, O blocks at corner v1 (t3) 89
# board.game_board = ["O", "X", "X", "", "X", "", "", "O", ""]  # X took edge, adjacent corner and center, O blocks at corner v2 (b1) 90
# board.game_board = ["O", "X", "", "", "O", "", "", "X", "X"]  # X took corner, adjacent edge and opposite edge, O blocks at corner v1 (b1) 91
# board.game_board = ["X", "", "", "X", "O", "X", "", "", "O"]  # X took corner, adjacent edge and opposite edge, O blocks at corner v2 (b1) 92
# board.game_board = ["", "X", "O", "", "O", "X", "X", "", ""]  # X took adjacent edges and opposite corner, O takes open corner v1 (t1/b3) 93
# board.game_board = ["X", "", "", "", "O", "X", "", "X", "O"]  # X took adjacent edges and opposite corner, O takes open corner v2 (t3/b1) 94
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
# board.game_board = ["X", "O", "X", "", "O", "", "O", "X", "X"]  # Perfect X - blocks at corner, O blocks at edge v1 (m3) 56
# board.game_board = ["X", "X", "O", "", "O", "", "X", "O", "X"]  # Perfect X - blocks at corner, O blocks at edge v2 (m1) 57
# board.game_board = ["X", "", "X", "O", "O", "X", "X", "", "O"]  # Perfect X - blocks at corner, O blocks at edge v3 (t2) 58
# board.game_board = ["O", "", "X", "X", "O", "O", "X", "", "X"]  # Perfect X - blocks at corner, O blocks at edge v4 (b2) 59
#-----------------------------------------------------------------------------
# board.game_board = ["X", "O", "X", "O", "O", "X", "", "X", ""]  # X blocks at edge, O blocks at corner v1 (b3) 95
# board.game_board = ["", "X", "X", "X", "O", "O", "", "O", "X"]  # X blocks at edge, O blocks at corner v2 (t1) 96
# board.game_board = ["X", "X", "O", "O", "O", "X", "X", "", ""]  # X blocks at edge, O takes random position v1 (b2/b3) 97
# board.game_board = ["X", "O", "X", "", "O", "X", "", "X", "O"]  # X blocks at edge, O takes random position v2 (m1/b1) 98
# board.game_board = ["X", "", "X", "X", "O", "O", "O", "X", ""]  # X blocks at corner, O blocks at edge v1 (t2) 99
# board.game_board = ["X", "X", "O", "", "O", "X", "X", "O", ""]  # X blocks at corner, O blocks at edge v2 (m1) 100
# board.game_board = ["O", "", "X", "X", "X", "O", "O", "X", ""]  # X takes random open edge, O blocks at edge v1 (t2) 101
# board.game_board = ["O", "X", "O", "", "X", "X", "", "O", "X"]  # X takes random open edge, O blocks at edge v2 (m1) 102
# board.game_board = ["O", "X", "", "X", "X", "O", "X", "O", ""]  # X takes random non-opposite corner, O blocks at corner v1 (t3) 103
# board.game_board = ["O", "X", "X", "X", "X", "O", "", "O", ""]  # X takes random non-opposite corner, O blocks at corner v2 (b1) 104
# board.game_board = ["O", "", "O", "X", "X", "O", "X", "", "X"]  # X blocks at corner, O blocks at corner v1 (t2) 105
# board.game_board = ["O", "X", "X", "", "X", "", "O", "O", "X"]  # X blocks at corner, O blocks at corner v2 (m1) 106
# board.game_board = ["O", "X", "", "X", "O", "", "O", "X", "X"]  # X blocks at edge or corner, O wins via fork v1 (t3) 107
# board.game_board = ["X", "", "X", "X", "O", "X", "O", "", "O"]  # X blocks at edge or corner, O wins via fork v2 (b2) 108
# board.game_board = ["X", "X", "O", "", "O", "X", "X", "", "O"]  # X blocks at corner, O blocks at edge v1 (m1) 109
# board.game_board = ["X", "", "O", "", "O", "X", "X", "X", "O"]  # X blocks at corner, O blocks at edge v1 (m1) 110
#-----------------------------------------------------------------------------
# Round 9 - X
#-----------------------------------------------------------------------------
# board.game_board = ["X", "O", "X", "", "O", "O", "O", "X", "X"]  # X ties v1 (m1)
# board.game_board = ["X", "", "O", "O", "O", "X", "X", "O", "X"]  # X ties v2 (t2)
# board.game_board = ["X", "O", "X", "O", "O", "X", "X", "", "O"]  # X ties v3 (b2)
# board.game_board = ["O", "", "X", "X", "O", "O", "X", "O", "X"]  # X ties v4 (t2)
#-----------------------------------------------------------------------------
# Random board tests
#-----------------------------------------------------------------------------
#
#-----------------------------------------------------------------------------

round = board.get_round(board.x_count, board.o_count)
puts "Round: #{round}"
mark = board.get_mark(board.x_count, board.o_count)
wins = board.wins
x_pos = board.get_x
o_pos = board.get_o
# # puts "Player: #{x_pos}"  # X rounds (odd)
# # puts "Opponent: #{o_pos}"  # X rounds (odd)
# puts "Player: #{o_pos}"  # O rounds (even)
# puts "Opponent: #{x_pos}"  # O rounds (even)
puts p1.get_move(board.game_board, round, mark, wins, x_pos, o_pos)
#-----------------------------------------------------------------------------
# player = board.get_x
# opponent = board.get_o
# p p1.opening_x(wins, player, opponent, round)
#-----------------------------------------------------------------------------