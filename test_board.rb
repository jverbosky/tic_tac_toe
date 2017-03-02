require "minitest/autorun"
require_relative "board.rb"

class TestTicTacToe < Minitest::Test

  def test_1_verify_board_array_exists
    board = Board.new
    result = Array.new(9, "")
    assert_equal(result, board.t_board)
  end

  def test_2_verify_update_X_at_1st
    board = Board.new
    board.set_position(0, "X")
    result = ["X", "", "", "", "", "", "", "", ""]
    assert_equal(result, board.t_board)
  end

  def test_3_verify_update_O_at_5th_X_at_1st
    board = Board.new
    board.set_position(0, "X")
    board.set_position(4, "O")
    result = ["X", "", "", "", "O", "", "", "", ""]
    assert_equal(result, board.t_board)
  end

  def test_4_verify_update_X_at_8th_O_at_5th_X_at_1st
    board = Board.new
    board.t_board = ["X", "", "", "", "O", "", "", "", ""]
    board.set_position(7, "X")
    result = ["X", "", "", "", "O", "", "", "X", ""]
    assert_equal(result, board.t_board)
  end

  def test_5_verify_spot_already_taken
    board = Board.new
    board.t_board = ["X", "", "", "", "O", "", "", "", ""]
    result = board.check_position?(4)
    assert_equal(false, result)
  end

  def test_6_verify_spot_is_open
    board = Board.new
    board.t_board = ["X", "", "", "", "O", "", "", "", ""]
    result = board.check_position?(3)
    assert_equal(true, result)
  end

  def test_7_verify_all_spots_full
    board = Board.new
    board.t_board = ["X", "O", "X", "X", "O", "O", "O", "X", "X"]
    result = board.check_full?
    assert_equal(true, result)
  end

  def test_8_verify_board_almost_full
    board = Board.new
    board.t_board = ["X", "O", "", "X", "O", "O", "O", "X", "X"]
    result = board.check_full?
    assert_equal(false, result)
  end


end