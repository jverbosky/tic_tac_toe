# game_board = ["", "", "", "", "", "", "", "", ""]
# game_board = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

# 0 1 2
# 3 4 5
# 6 7 8

wins = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
game_board = ["O", "O", "O", "X", "", "X", "X", "", ""]

# Output array positions that match marks
o = game_board.each_index.select { |position| game_board[position] == "O" }
x = game_board.each_index.select { |position| game_board[position] == "X" }

p o  # [0, 1, 2] - winner
p x  # [3, 5, 6] - not a winner

intersection_test = [0, 1, 2]

# def game_won?(current_positions, win)
#   current_positions & win == win
# end

# p game_won?(o, intersection_test)

def game_won?(current_positions)
  wins = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
  won = false
  wins.each { |win| won = true if current_positions & win == win }
  return won
end

puts game_won?(x)
puts game_won?(o)





# puts game_board[0..2]
# puts mark

# game_board.each do |position|


# if game_board[0..2] == mark
#   puts "win"
# else
#   puts "keep playing..."
# end



# case win
#   game_board[0..2] = mark
# end