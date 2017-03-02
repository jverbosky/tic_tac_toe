require_relative "board.rb"

class PlayerSequential

  attr_reader :moves

  def initialize
    @moves = ["t1", "t2", "t3", "m1", "m2", "m3", "b1", "b2", "b3"]
  end




end







  def test_1_verify_first_move
    player = PlayerSequential.new
    result = player.move
    assert_equal("t1", result)
  end