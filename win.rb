require "minitest/autorun"
require_relative "board.rb"
require_relative "win.rb"

class TestWin < Minitest::Test

  def test_1_x_won_false
    board = Board.new
    board.game_board = ["", "X", "", "O", "X", "", "O", "", "X"]
    result = win.x_won?
    assert_equal(false, result)
  end

  def test_2_x_won_true
    board = Board.new
    board.game_board = ["O", "O", "X", "O", "", "X", "X", "O", "X"]
    result = win.x_won?
    assert_equal(true, result)
  end

  def test_3_o_won_false
    board = Board.new
    board.game_board = ["", "X", "", "O", "X", "", "O", "", "X"]
    result = win.o_won?
    assert_equal(false, result)
  end

  def test_4_o_won_true
    board = Board.new
    board.game_board = ["O", "X", "X", "", "O", "X", "X", "O", "O"]
    result = win.o_won?
    assert_equal(true, result)
  end

end