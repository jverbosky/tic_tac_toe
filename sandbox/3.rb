game_board = ["", "", "", "", "", "", "", "", ""]
game_board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]

game_board = ["X", "O", "", "", "O", "", "X", "", ""]
game_board = ["X", "", "", "O", "O", "", "X", "", ""]
game_board = ["X", "", "", "", "O", "O", "X", "", ""]
game_board = ["X", "", "", "", "O", "", "X", "O", ""]

game_board = ["", "O", "X", "", "O", "", "", "", "X"]
game_board = ["", "", "X", "O", "O", "", "", "", "X"]
game_board = ["", "", "X", "", "O", "O", "", "", "X"]
game_board = ["", "", "X", "", "O", "", "", "O", "X"]


game_board = ["", "", "", "", "", "", "", "", ""]

wins = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]



def block(game_board)  # input board to check current positions


end

# ____________________________


# ____________________________

# X
# ____________________________

# 1) Take a corner [0, 2, 6, 8]

# 2) Take opposite corner
#   - if 0 then 6
#   - if 2 then 8
#   - if 6 then 0
#   - if 8 then 2

# 3 - end) Block

# ____________________________

# O
# ____________________________

# 1) Take center [4]

# 2) Take an edge [1, 3, 5, 7]

# 3 - end) Block
# ____________________________
