require "minitest/autorun"
require_relative "../board/board.rb"

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
    result = board.board_full?
    assert_equal(true, result)
  end

  def test_8_verify_board_almost_full
    board = Board.new
    board.game_board = ["X", "O", "", "X", "O", "O", "O", "X", "X"]
    result = board.board_full?
    assert_equal(false, result)
  end

  def test_9_get_x_positions
    board = Board.new
    board.game_board = ["X", "O", "", "X", "O", "O", "O", "X", "X"]
    result = board.get_x
    assert_equal([0, 3, 7, 8], result)
  end

  def test_10_get_o_positions
    board = Board.new
    board.game_board = ["X", "O", "", "X", "O", "O", "O", "X", "X"]
    result = board.get_o
    assert_equal([1, 4, 5, 6], result)
  end

  def test_11_get_empty_board
    board = Board.new
    result = ["", "", "", "", "", "", "", "", ""]
    assert_equal(result, board.game_board)
  end

  def test_12_get_player_first_move
    board = Board.new
    result = board.get_mark(board.x_count, board.o_count)
    assert_equal("X", result)
  end

  def test_13_get_player_second_move
    board = Board.new
    board.game_board = ["", "", "", "", "X", "", "", "", ""]
    result = board.get_mark(board.x_count, board.o_count)
    assert_equal("O", result)
  end

  def test_14_get_player_third_move
    board = Board.new
    board.game_board = ["", "", "", "", "X", "", "O", "", ""]
    result = board.get_mark(board.x_count, board.o_count)
    assert_equal("X", result)
  end

  def test_15_get_player_seventh_move
    board = Board.new
    board.game_board = ["O", "X", "", "", "O", "X", "X", "", "O"]
    result = board.get_mark(board.x_count, board.o_count)
    assert_equal("X", result)
  end

  def test_16_get_player_eighth_move
    board = Board.new
    board.game_board = ["O", "X", "X", "", "O", "X", "X", "", "O"]
    result = board.get_mark(board.x_count, board.o_count)
    assert_equal("O", result)
  end

  def test_17_get_round_first_move
    board = Board.new
    result = board.get_round(board.x_count, board.o_count)
    assert_equal(1, result)
  end

  def test_18_get_round_second_move
    board = Board.new
    board.game_board = ["", "", "", "", "X", "", "", "", ""]
    result = board.get_round(board.x_count, board.o_count)
    assert_equal(2, result)
  end

  def test_19_get_round_third_move
    board = Board.new
    board.game_board = ["", "", "", "", "X", "", "O", "", ""]
    result = board.get_round(board.x_count, board.o_count)
    assert_equal(3, result)
  end

  def test_20_get_round_seventh_move
    board = Board.new
    board.game_board = ["O", "X", "", "", "O", "X", "X", "", "O"]
    result = board.get_round(board.x_count, board.o_count)
    assert_equal(7, result)
  end

  def test_21_get_round_eighth_move
    board = Board.new
    board.game_board = ["O", "X", "X", "", "O", "X", "X", "", "O"]
    result = board.get_round(board.x_count, board.o_count)
    assert_equal(8, result)
  end

  def test_22_game_won_false
    board = Board.new
    result = board.game_won?(board.get_x)
    assert_equal(false, result)
  end

  def test_23_game_won_true_x
    board = Board.new
    board.game_board = ["O", "O", "X", "O", "", "X", "X", "O", "X"]
    result = board.game_won?(board.get_x)
    assert_equal(true, result)
  end

  def test_24_game_won_true_o
    board = Board.new
    board.game_board = ["O", "X", "X", "", "O", "X", "X", "O", "O"]
    result = board.game_won?(board.get_o)
    assert_equal(true, result)
  end

  def test_25_x_won_false
    board = Board.new
    board.game_board = ["", "X", "", "O", "X", "", "O", "", "X"]
    result = board.x_won?(board.get_x)
    assert_equal(false, result)
  end

  def test_26_x_won_true
    board = Board.new
    board.game_board = ["O", "O", "X", "O", "", "X", "X", "O", "X"]
    result = board.x_won?(board.get_x)
    assert_equal(true, result)
  end

  def test_27_o_won_false
    board = Board.new
    board.game_board = ["", "X", "", "O", "X", "", "O", "", "X"]
    result = board.o_won?(board.get_o)
    assert_equal(false, result)
  end

  def test_28_o_won_true
    board = Board.new
    board.game_board = ["O", "X", "X", "", "O", "X", "X", "O", "O"]
    result = board.o_won?(board.get_o)
    assert_equal(true, result)
  end

end