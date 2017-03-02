# class to determine player turn by looking at board layout
require_relative "board.rb"

class Turn

  def initialize()
    @player_1 = "X"
    @player_2 = "O"
  end

  def get_player(game_board)
    x_count = game_board.count("X")
    o_count = game_board.count("O")
    x_count > o_count ? @player_2 : @player_1
  end

end

# Sandbox testing
# board = Board.new
# # board.game_board = ["", "", "", "", "X", "", "", "", ""]  # O
# # board.game_board = ["", "", "", "", "X", "", "O", "", ""]  # X
# # board.game_board = ["O", "X", "", "", "O", "X", "X", "", "O"]  # X
# # board.game_board = ["O", "X", "X", "", "O", "X", "X", "", "O"]  # O
# turn = Turn.new
# result = turn.get_player(board.game_board)
# puts result