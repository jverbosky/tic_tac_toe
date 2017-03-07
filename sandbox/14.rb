# Round 7 Research

# 85 - 86

# X should take either open edge for a chance to win

# O - X   O X O
# X X O   - X -
# O - -   - O X

# Pattern:
# 1) Adjacent opponent corners
# 2) Opponent edge on opposite side

sides = [[0, 1, 2], [2, 5, 8], [6, 7, 8], [0, 3, 6]]
corners = [0, 2, 6, 8]
adjcor = [[8, 6], [2, 8], [6, 0], [0, 2]]
edges = [1, 3, 5, 7]

player = [2, 3, 4]
opponent = [0, 5, 6]
# player = [1, 4, 8]
# opponent = [0, 2, 7]

taken = player + opponent
taken_edges = taken & edges
c_index = 11 # adjcor index that contains opponent corners
e_index = 17 # edges index that contains opponent corners

# Collect indexes of opponent's adjacent corner pair and opposite edge
edges.each_with_index { |edge, edge_index| e_index = edge_index if opponent.include? edge }
adjcor.each_with_index { |pair, a_index| c_index = a_index if (opponent & pair).size == 2 }
if c_index == e_index  # if index of adjacent corners and corner match, they oppose
  position = (edges - taken_edges).sample  # so take random open edge
end

p position

#------------------------------------------

# 87 - 88 > 103 - 104

# X should take corner that not opposite from O corner

# O X -
# X X O  # both boards same in r7
# - O -

# player = [1, 3, 4]
# opponent = [0, 5, 7]
# player = [1, 3, 4]
# opponent = [0, 5, 7]



