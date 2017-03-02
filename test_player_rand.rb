require "minitest/autorun"
require_relative "player_rand.rb"

class TestPlayerRandom < Minitest::Test

  def test_1_verify_random_move
    board = Board.new
    p1 = PlayerRandom.new
    turn = Turn.new
    round = turn.get_round(board.x_count, board.o_count)
    move = p1.get_move(round)
    result = p1.moves.include?(move)
    assert_equal(true, result)
  end

end