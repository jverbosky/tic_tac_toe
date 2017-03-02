require "minitest/autorun"
require_relative "board.rb"

class TestBoard < Minitest::Test

  def test_1_verify_board_array_exists
    board = Board.new
    result = Array.new(9, "")
    assert_equal(result, board.game_board)
  end

  def test_2_verify_update_X_at_1st
    board = Board.new
    board.set_position(0, "X")
    result = ["X", "", "", "", "", "", "", "", ""]
    assert_equal(result, board.game_board)
  end

  def test_3_verify_update_O_at_5th_X_at_1st
    board = Board.new
    board.set_position(0, "X")
    board.set_position(4, "O")
    result = ["X", "", "", "", "O", "", "", "", ""]
    assert_equal(result, board.game_board)
  end

  def test_4_verify_update_X_at_8th_O_at_5th_X_at_1st
    board = Board.new
    board.game_board = ["X", "", "", "", "O", "", "", "", ""]
    board.set_position(7, "X")
    result = ["X", "", "", "", "O", "", "", "X", ""]
    assert_equal(result, board.game_board)
  end

  def test_5_verify_spot_already_taken
    board = Board.new
    board.game_board = ["X", "", "", "", "O", "", "", "", ""]
    result = board.position_open?(4)
    assert_equal(false, result)
  end

  def test_6_verify_spot_is_open
    board = Board.new
    board.game_board = ["X", "", "", "", "O", "", "", "", ""]
    result = board.position_open?(3)
    assert_equal(true, result)
  end

  def test_7_verify_all_spots_full
    board = Board.new
    board.game_board = ["X", "O", "X", "X", "O", "O", "O", "X", "X"]
    result = board.board_full?()
    assert_equal(true, result)
  end

  def test_8_verify_board_almost_full
    board = Board.new
    board.game_board = ["X", "O", "", "X", "O", "O", "O", "X", "X"]
    result = board.board_full?()
    assert_equal(false, result)
  end

  def test_9_get_x_positions
    board = Board.new
    board.game_board = ["X", "O", "", "X", "O", "O", "O", "X", "X"]
    result = board.get_x()
    assert_equal([0, 3, 7, 8], result)
  end

  def test_10_get_o_positions
    board = Board.new
    board.game_board = ["X", "O", "", "X", "O", "O", "O", "X", "X"]
    result = board.get_o()
    assert_equal([1, 4, 5, 6], result)
  end

  def test_11_x_won_false
    board = Board.new
    board.game_board = ["", "X", "", "O", "X", "", "O", "", "X"]
    result = board.x_won?()
    assert_equal(false, result)
  end

  def test_12_x_won_true
    board = Board.new
    board.game_board = ["O", "O", "X", "O", "", "X", "X", "O", "X"]
    result = board.x_won?()
    assert_equal(true, result)
  end

  def test_13_o_won_false
    board = Board.new
    board.game_board = ["", "X", "", "O", "X", "", "O", "", "X"]
    result = board.o_won?()
    assert_equal(false, result)
  end

  def test_14_o_won_true
    board = Board.new
    board.game_board = ["O", "X", "X", "", "O", "X", "X", "O", "O"]
    result = board.o_won?()
    assert_equal(true, result)
  end

  def test_15_get_player_first_move
    board = Board.new
    result = board.get_player()
    assert_equal("X", result)
  end

  def test_16_get_player_second_move
    board = Board.new
    board.game_board = ["", "", "", "", "X", "", "", "", ""]
    result = board.get_player()
    assert_equal("O", result)
  end

  def test_17_get_player_third_move
    board = Board.new
    board.game_board = ["", "", "", "", "X", "", "O", "", ""]
    result = board.get_player()
    assert_equal("X", result)
  end

  def test_18_get_player_seventh_move
    board = Board.new
    board.game_board = ["O", "X", "", "", "O", "X", "X", "", "O"]
    result = board.get_player()
    assert_equal("X", result)
  end

  def test_19_get_player_eighth_move
    board = Board.new
    board.game_board = ["O", "X", "X", "", "O", "X", "X", "", "O"]
    result = board.get_player()
    assert_equal("O", result)
  end

  def test_20_get_first_move
    board = Board.new
    board.get_move(4)
    result = ["", "", "", "", "X", "", "", "", ""]
    assert_equal(result, board.game_board)
  end

  def test_20_get_second_move
    board = Board.new
    board.game_board = ["", "", "", "", "X", "", "", "", ""]
    board.get_move(6)
    result = ["", "", "", "", "X", "", "O", "", ""]
    assert_equal(result, board.game_board)
  end

  def test_21_get_third_move
    board = Board.new
    board.game_board = ["", "", "", "", "X", "", "O", "", ""]
    board.get_move(0)
    result = ["X", "", "", "", "X", "", "O", "", ""]
    assert_equal(result, board.game_board)
  end

  def test_21_get_fourth_move
    board = Board.new
    board.game_board = ["X", "", "", "", "X", "", "O", "", ""]
    board.get_move(8)
    result = ["X", "", "", "", "X", "", "O", "", "O"]
    assert_equal(result, board.game_board)
  end

  def test_22_get_empty_board
    board = Board.new
    result = board.get_board()
    assert_equal(result, board.game_board)
  end

  def test_23_get_populated_board
    board = Board.new
    board.game_board = ["O", "X", "X", "", "O", "X", "X", "", "O"]
    result = board.get_board()
    assert_equal(result, board.game_board)
  end

end