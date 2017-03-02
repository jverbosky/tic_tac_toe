require "minitest/autorun"
require_relative "player_seq.rb"

class TestPlayerSequential < Minitest::Test

  def test_1_verify_first_move
    board = Board.new
    p1 = PlayerSequential.new
    turn = Turn.new
    round = turn.get_round(board.x_count, board.o_count)
    result = p1.get_move(round)
    assert_equal("t1", result)
  end

  def test_2_verify_second_move
    board = Board.new
    p1 = PlayerSequential.new
    turn = Turn.new
    board.game_board = ["X", "", "", "", "", "", "", "", ""]
    round = turn.get_round(board.x_count, board.o_count)
    result = p1.get_move(round)
    assert_equal("t2", result)
  end

  def test_3_verify_third_move
    board = Board.new
    p1 = PlayerSequential.new
    turn = Turn.new
    board.game_board = ["X", "X", "", "", "", "", "", "", ""]
    round = turn.get_round(board.x_count, board.o_count)
    result = p1.get_move(round)
    assert_equal("t3", result)
  end

  def test_4_verify_fourth_move
    board = Board.new
    p1 = PlayerSequential.new
    turn = Turn.new
    board.game_board = ["X", "X", "X", "", "", "", "", "", ""]
    round = turn.get_round(board.x_count, board.o_count)
    result = p1.get_move(round)
    assert_equal("m1", result)
  end

  def test_5_verify_fifth_move
    board = Board.new
    p1 = PlayerSequential.new
    turn = Turn.new
    board.game_board = ["X", "X", "X", "X", "", "", "", "", ""]
    round = turn.get_round(board.x_count, board.o_count)
    result = p1.get_move(round)
    assert_equal("m2", result)
  end

  def test_6_verify_sixth_move
    board = Board.new
    p1 = PlayerSequential.new
    turn = Turn.new
    board.game_board = ["X", "X", "X", "X", "X", "", "", "", ""]
    round = turn.get_round(board.x_count, board.o_count)
    result = p1.get_move(round)
    assert_equal("m3", result)
  end

  def test_7_verify_seventh_move
    board = Board.new
    p1 = PlayerSequential.new
    turn = Turn.new
    board.game_board = ["X", "X", "X", "X", "X", "X", "", "", ""]
    round = turn.get_round(board.x_count, board.o_count)
    result = p1.get_move(round)
    assert_equal("b1", result)
  end

  def test_8_verify_eigth_move
    board = Board.new
    p1 = PlayerSequential.new
    turn = Turn.new
    board.game_board = ["X", "X", "X", "X", "X", "X", "X", "", ""]
    round = turn.get_round(board.x_count, board.o_count)
    result = p1.get_move(round)
    assert_equal("b2", result)
  end

  def test_9_verify_final_move
    board = Board.new
    p1 = PlayerSequential.new
    turn = Turn.new
    board.game_board = ["X", "X", "X", "X", "X", "X", "X", "X", ""]
    round = turn.get_round(board.x_count, board.o_count)
    result = p1.get_move(round)
    assert_equal("b3", result)
  end

end