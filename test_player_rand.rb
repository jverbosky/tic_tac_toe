require "minitest/autorun"
require_relative "player_rand.rb"

class TestPlayerRandom < Minitest::Test

  def test_1_verify_random_move
    board = Board.new
    p1 = PlayerRandom.new
    move = p1.get_move(board.game_board)
    result = p1.moves.include?(move)
    assert_equal(true, result)
  end

end