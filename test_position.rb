require "minitest/autorun"
require_relative "position.rb"

class TestPosition < Minitest::Test

  def test_1_get_array_index_for_t1
    position = Position.new
    move = "t1"
    result = position.get_index(move)
    assert_equal(0, result)
  end

end