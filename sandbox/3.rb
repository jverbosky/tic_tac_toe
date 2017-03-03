require_relative "../board.rb"

# round_4 = ["", "", "", "", "", "", "", "", ""]
# round_4 = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]

# All possible board positions after round 4

# X O -
# - O -
# - - X

# round_4 = ["X", "O", "", "", "O", "", "", "", "X"]  # variation 1 - X blocks O at 7
# round_4 = ["X", "", "", "O", "O", "", "", "", "X"]  # variation 2 - X blocks O at 5
# round_4 = ["X", "", "", "", "O", "O", "", "", "X"]  # variation 3 - X blocks O at 3
# round_4 = ["X", "", "", "", "O", "", "", "O", "X"]  # variation 4 - X blocks O at 1
# round_4 = ["", "O", "X", "", "O", "", "X", "", ""]  # variation 5 - X blocks O at 7
# round_4 = ["", "", "X", "O", "O", "", "X", "", ""]  # variation 6 - X blocks O at 5
# round_4 = ["", "", "X", "", "O", "O", "X", "", ""]  # variation 7 - X blocks O at 3
# round_4 = ["", "", "X", "", "O", "", "X", "O", ""]  # variation 8 - X blocks O at 1

# X O -
# - O -
# - X X

round_5 = ["X", "O", "", "", "O", "", "", "X", "X"]  # variation 1 - O blocks X at
# round_5 = ["X", "", "", "O", "O", "X", "", "", "X"]  # variation 2 - O blocks X at
# round_5 = ["X", "", "", "X", "O", "O", "", "", "X"]  # variation 3 - O blocks X at
# round_5 = ["X", "X", "", "", "O", "", "", "O", "X"]  # variation 4 - O blocks X at
# round_5 = ["", "O", "X", "", "O", "", "X", "X", ""]  # variation 5 - O blocks X at
# round_5 = ["", "", "X", "O", "O", "X", "X", "", ""]  # variation 6 - O blocks X at
# round_5 = ["", "", "X", "X", "O", "O", "X", "", ""]  # variation 7 - O blocks X at
# round_5 = ["", "X", "X", "", "O", "", "X", "O", ""]  # variation 8 - O blocks X at

# X O -
# - O -
# - X X

# round_6 = ["X", "O", "", "", "O", "", "O", "X", "X"]  # variation 1
# round_6 = ["X", "", "O", "O", "O", "X", "", "", "X"]  # variation 2
# round_6 = ["X", "", "", "X", "O", "O", "O", "", "X"]  # variation 3
# round_6 = ["X", "", "", "", "O", "", "", "O", "X"]  # variation 4
# round_6 = ["", "O", "X", "", "O", "", "X", "X", ""]  # variation 5 = O block same as variation 1
# round_6 = ["", "", "X", "O", "O", "X", "X", "", ""]  # variation 6 = O block same as variation 2
# round_6 = ["", "", "X", "X", "O", "O", "X", "", ""]  # variation 7 = O block same as variation 3
# round_6 = ["", "", "X", "", "O", "", "X", "O", ""]  # variation 8 = O block same as variation 4


wins = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

def block_o(wins, x_pos, o_pos) # pos of player to block
  block = []
  wins.each { |win| block = win - o_pos if (win - o_pos).count == 1 }
  block
end

board = Board.new
board.game_board = round_5
# print board  # The board is: ["X", "O", "", "", "O", "", "X", "", ""]

# x_pos = board.get_x
# p x_pos
# o_pos = board.get_o
# p o_pos

# Round 5 - block O
# v1/5 = [7], v2/6 = [5], v3/7 = [3], v4/8 = [1]
# p block_o(wins, x_pos, o_pos)



# ____________________________________________________________________
#
# Block X Variation (will likely merge, but here for reference)
# ____________________________________________________________________

# Round 6 - block X
# v1/5 = [4], v2/6 = [], v3/7 = [], v4/8 = []
def block_x(wins, o_pos, x_pos) # pos of player to block
  block = []
  wins.each do |win|
    if (win - x_pos).count == 1
      block = win - x_pos
    end
  end
  block
end

win_1 = [0, 4, 8] # O at 4
win_2 = [6, 7, 8] # nobody at 6
x_pos = [0, 7, 8]
o_pos = [1, 4]

# p block_x(wins, o_pos, x_pos)

# Compare current X position against winning position
# x_pos = [0, 6]
# win = [0, 3, 6]
# block = win - x_pos  # [0, 3, 6] - [0, 6]
# puts block  # 3

# ____________________________________________________________________
#
# Strategy notes
# ____________________________________________________________________

# X
# ____________________________

# 1) Take a corner [0, 2, 6, 8]

# 2) Take opposite corner
#   - if 0 then 8
#   - if 2 then 6
#   - if 6 then 2
#   - if 8 then 0

# 3 - end) Block

# ____________________________

# O
# ____________________________

# 1) Take center [4]

# 2) Take an edge [1, 3, 5, 7]

# 3 - end) Block
# ____________________________
