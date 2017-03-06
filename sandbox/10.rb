# Revised 67 -68 logic to grab edge opposite corner X

# X - -
# - O -  > should take m3 (5)
# - X -

# round_4_X_took_corner_and_non_adjacent_edge_O_takes_edge_opposite_corner_X_v1

board = ["X", "", "", "", "O", "", "", "X", ""]  # need to take m3
sides = [[0, 1, 2], [2, 5, 8], [6, 7, 8], [0, 3, 6]]
adjedg = [[5, 7], [3, 7], [1, 5], [1, 3]]
edges = [1, 3, 5, 7]
corners = [0, 2, 6, 8]

opponent = [0, 7]
player = [4]

corner = corners & opponent
p corner  # [0]

edge = edges & opponent
p edge  # [7]

target = []
# collect positions of edges from sides without opponent corner
sides.each { |side| target += (side & edges) if (side & corner).size == 0 }
p target  # [5, 7]

position = target - edge  # get position of open edge
p position # [5]