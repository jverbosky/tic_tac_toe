# be sure to use the unit test versions of attr_ in board.rb and game.rb
# - attr_accessor in /board/board.rb
# - attr_reader in /game/game.rb

require "minitest/autorun"
require_relative "../players/player_seq.rb"
require_relative "../game/game.rb"

class TestPlayerSequential < Minitest::Test

  def test_1_verify_t1_board_empty
    game = Game.new
    p1 = PlayerSequential.new
    result = p1.get_move(game.board.game_board)
    assert_equal("t1", result)
  end

  def test_2_verify_t1_board_not_empty
    game = Game.new
    p1 = PlayerSequential.new
    game.board.game_board = ["", "", "", "X", "", "", "O", "", ""]
    result = p1.get_move(game.board.game_board)
    assert_equal("t1", result)
  end

  def test_3_verify_m2
    game = Game.new
    p1 = PlayerSequential.new
    game.board.game_board = ["X", "O", "O", "X", "", "", "", "X", "O"]
    result = p1.get_move(game.board.game_board)
    assert_equal("m2", result)
  end

  def test_4_verify_b1
    game = Game.new
    p1 = PlayerSequential.new
    game.board.game_board = ["X", "O", "X", "O", "X", "O", "", "", ""]
    result = p1.get_move(game.board.game_board)
    assert_equal("b1", result)
  end

  def test_5_verify_b3
    game = Game.new
    p1 = PlayerSequential.new
    game.board.game_board = ["X", "O", "X", "O", "O", "X", "O", "X", ""]
    result = p1.get_move(game.board.game_board)
    assert_equal("b3", result)
  end

end