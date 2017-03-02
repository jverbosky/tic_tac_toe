require_relative "board.rb"
require_relative "turn.rb"

class PlayerSequential

  def initialize
    @moves = ["t1", "t2", "t3", "m1", "m2", "m3", "b1", "b2", "b3"]
  end

  def move(round)
    m_index = round - 1
    position = @moves[m_index]
  end

end

# Sandbox testing
# board = Board.new
# p1 = PlayerSequential.new
# turn = Turn.new
# # board.game_board = ["", "", "", "", "X", "", "", "", ""]  # t2
# # board.game_board = ["", "", "", "", "X", "", "O", "", ""]  # t3
# # board.game_board = ["O", "X", "", "", "O", "X", "X", "", "O"]  # b1
# # board.game_board = ["O", "X", "X", "", "O", "X", "X", "", "O"]  # b2
# round = turn.get_round(board.x_count, board.o_count)
# puts round
# puts p1.move(round)