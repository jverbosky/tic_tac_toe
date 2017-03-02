require "minitest/autorun"
require_relative "player_seq.rb"

class TestPlayerSequential < Minitest::Test

  def test_1_verify_first_move
    board = Board.new
    p1 = PlayerSequential.new
    turn = Turn.new
    round = turn.get_round
    result = p1.move(round)
    assert_equal("t1", result)
  end

end