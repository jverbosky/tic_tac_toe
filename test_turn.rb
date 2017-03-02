require "minitest/autorun"
require_relative "turn.rb"

class TestTurn < Minitest::Test

  def test_1_get_player_first_move
    board = Board.new
    turn = Turn.new
    result = turn.get_player(board.game_board)
    assert_equal("X", result)
  end

  def test_2_get_player_second_move
    board = Board.new
    board.game_board = ["", "", "", "", "X", "", "", "", ""]
    turn = Turn.new
    result = turn.get_player(board.game_board)
    assert_equal("O", result)
  end

  def test_3_get_player_third_move
    board = Board.new
    board.game_board = ["", "", "", "", "X", "", "O", "", ""]
    turn = Turn.new
    result = turn.get_player(board.game_board)
    assert_equal("X", result)
  end

  def test_4_get_player_seventh_move
    board = Board.new
    board.game_board = ["O", "X", "", "", "O", "X", "X", "", "O"]
    turn = Turn.new
    result = turn.get_player(board.game_board)
    assert_equal("X", result)
  end

  def test_5_get_player_eighth_move
    board = Board.new
    board.game_board = ["O", "X", "X", "", "O", "X", "X", "", "O"]
    turn = Turn.new
    result = turn.get_player(board.game_board)
    assert_equal("O", result)
  end

end