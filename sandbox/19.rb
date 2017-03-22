# - - X
# - - O
# X - O



@sides = [[0, 1, 2], [2, 5, 8], [6, 7, 8], [0, 3, 6]]
@opcor_1 = [0, 8]  # opposite corners - set 1
@opcor_2 = [2, 6]  # opposite corners - set 2
edges = [1, 3, 5, 7]

# player = [2, 6]
# opponent = [5, 8]
# player = [0, 8]
opponent = [3, 6]
player = [0, 2]


taken = player + opponent
taken_edges = taken & edges
c_index = 11 # adjcor index that contains opponent corners
e_index = 17 # edges index that contains opponent corners

def adj_cor_edg?(player, opponent)
  taken = player + opponent
  full_side = false
  op_cor = false
  @sides.each { |side| full_side = true if (taken & side).size == 3 }
  op_cor = true if (player & @opcor_1).size == 2 || (player & @opcor_2).size == 2
  full_side && op_cor
end

p adj_cor_edg?(player, opponent)

# Collect indexes of opponent's adjacent corner pair and opposite edge
# edges.each_with_index { |edge, edge_index| e_index = edge_index if opponent.include? edge }
# adjcor.each_with_index { |pair, a_index| c_index = a_index if (opponent & pair).size == 2 }
# if c_index == e_index  # if index of adjacent corners and corner match, they oppose
#   position = (edges - taken_edges).sample  # so take random open edge
# end