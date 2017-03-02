require "minitest/autorun"
require_relative "player_rand.rb"

class TestPlayerRandom < Minitest::Test

  def test_1_verify_random_move
    p1 = PlayerRandom.new
    move = p1.move
    result = p1.moves.include?(move)
    assert_equal(true, result)
  end

end