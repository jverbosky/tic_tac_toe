# Lesson learned - x_count and o_count are so dependent on game_board in Board class that they shouldn't be abstracted from it

# class to determine player turn details by looking at board layout
require_relative "board.rb"

class Turn

  def initialize
    @p1 = "X"
    @p2 = "O"
  end

  def get_player(x_count, o_count)
    x_count > o_count ? @p2 : @p1
  end

  def get_round(x_count, o_count)
    x_count + o_count + 1
  end

end

# # Sandbox testing
# board = Board.new
# turn = Turn.new
# # board.game_board = ["", "", "", "", "X", "", "", "", ""]  # O
# # board.game_board = ["", "", "", "", "X", "", "O", "", ""]  # X
# # board.game_board = ["O", "X", "", "", "O", "X", "X", "", "O"]  # X
# # board.game_board = ["O", "X", "X", "", "O", "X", "X", "", "O"]  # O
# puts "X count: #{board.x_count}"
# puts "O count: #{board.o_count}"
# player = turn.get_player(board.x_count, board.o_count)
# puts "Player: #{player}"
# round = turn.get_round(board.x_count, board.o_count)
# puts "Round: #{round}"