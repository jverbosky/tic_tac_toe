require "minitest/autorun"
require_relative "player_seq.rb"

class TestPlayerSequential < Minitest::Test

  def test_1_verify_first_move
    player = PlayerSequential.new
    result = player.move
    assert_equal("t1", result)
  end

end