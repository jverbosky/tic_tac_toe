# be sure to use the unit test versions of attr_ in win.rb
# - attr_reader in win.rb

require "minitest/autorun"
require_relative "../game/win.rb"

class TestBoard < Minitest::Test

  def test_1_update_board
    win = Win.new
    board = ["", "X", "", "", "O", "", "", "X", ""]
    win.update_board(board)
    result = win.game_board
    assert_equal(board, result)
  end

  def test_2_verify_all_spots_full
    win = Win.new
    board = ["X", "O", "X", "X", "O", "O", "O", "X", "X"]
    win.update_board(board)
    result = win.board_full?
    assert_equal(true, result)
  end

  def test_3_verify_board_almost_full
    win = Win.new
    board = ["X", "O", "X", "X", "O", "O", "O", "X", ""]
    win.update_board(board)
    result = win.board_full?
    assert_equal(false, result)
  end

  def test_4_verify_game_won_true
    win = Win.new
    positions = [0, 1, 4, 8]
    result = win.get_win(positions)
    assert_equal(true, result)
  end

  def test_5_verify_game_won_false
    win = Win.new
    positions = [0, 3, 5, 7]
    result = win.get_win(positions)
    assert_equal(false, result)
  end

  def test_6_get_winning_positions_v1
    win = Win.new
    positions = [0, 1, 4, 8]
    win.get_win(positions)
    result = win.win
    assert_equal([0, 4, 8], result)
  end

  def test_7_get_winning_positions_v2
    win = Win.new
    positions = [0, 3, 5, 6, 7]
    win.get_win(positions)
    result = win.win
    assert_equal([0, 3, 6], result)
  end

  def test_8_verify_X_won_false
    win = Win.new
    board = ["X", "", "", "", "O", "", "", "", ""]
    win.update_board(board)
    result = win.x_won?
    assert_equal(false, result)
  end

  def test_9_verify_X_won_true
    win = Win.new
    board = ["X", "O", "", "", "O", "O", "X", "X", "X"]
    win.update_board(board)
    result = win.x_won?
    assert_equal(true, result)
  end

  def test_10_verify_O_won_false
    win = Win.new
    board = ["X", "", "", "", "O", "", "", "", ""]
    win.update_board(board)
    result = win.o_won?
    assert_equal(false, result)
  end

  def test_11_verify_O_won_true
    win = Win.new
    board = ["X", "", "", "O", "O", "O", "X", "", "X"]
    win.update_board(board)
    result = win.o_won?
    assert_equal(true, result)
  end

end