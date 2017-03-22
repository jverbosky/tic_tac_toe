# be sure to use the unit test versions of attr_ in board.rb and game.rb
# - attr_accessor in board.rb
# - attr_reader in game.rb

require "minitest/autorun"
require_relative "../game/game.rb"

class TestPosition < Minitest::Test

  def test_1_verify_board_output_new_game
    game = Game.new
    game.board.game_board = ["", "", "", "", "", "", "", "", ""]
    result = game.output_board
    assert_equal([["", "", ""], ["", "", ""], ["", "", ""]], result)
  end


  # def output_board
  #   rows = @board.game_board.each_slice(3).to_a
  # end

end