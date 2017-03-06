# X X -
# - O -
# - - -

# opcor_1 = [0, 8]  # opposite corners - set 1
# opcor_2 = [2, 6]  # opposite corners - set 2

# opponent = [8, 0]

# if (opponent & opcor_1).size > 0 || (opponent & opcor_2).size > 0
#   # puts "yes"
# end

# X - -   X - -
# - O -   - O X
# - X -   - - -

# corners = [0, 2, 6, 8]
# edges = [1, 3, 5, 7]
# opedg_1 = [1, 7]
# opedg_2 = [3, 5]
# opponent = [0, 7]
# sides = [[0, 1, 2], [2, 5, 8], [6, 7, 8], [0, 3, 6]]

# if (opponent & edges).size == 1 && (opponent & corners).size == 1  # if X has one edge and one corner
#   adjacent = false
#   sides.each { |side| adjacent = true if (opponent & side).count > 1 }  # check if edge and corner are adjacent
#   puts adjacent
#   if adjacent == false  # if edge and corner are not adjacent, determine which opedg pair edge is in
#     (opponent & opedg_1).size == 1 ? position = opedg_2.sample : position = opedg_1.sample  # take edge from other pair
#   end
# end

# puts position

# O - -   - - X
# - X -   - X -
# - - X   O - -

corners = [0, 2, 6, 8]
opcor_1 = [0, 8]
opcor_2 = [2, 6]
center = [4]

opponent = [2, 4]
player = [6]


current_positions = player + opponent  # array of all occupied board positions

# check if player and opponent positions occupy opposite corners and center (non-perfect X)
if (current_positions & (opcor_1 + center)).size == 3 || (current_positions & (opcor_2 + center)).size == 3
  if (current_positions & opcor_1).size == 2  # if so, determine which corners are taken
    position = opcor_2.sample  # take random corner from this opcor pair
  else
    position = opcor_1.sample  # or this opcor pair
  end
end

p position