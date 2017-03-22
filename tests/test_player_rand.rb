require "minitest/autorun"
require_relative "../players/player_rand.rb"
require_relative "../game/game.rb"

class TestPlayerRandom < Minitest::Test

  def test_1_verify_random_move
    game = Game.new
    p1 = PlayerRandom.new
    round = 1
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    move = p1.get_move(game.board.game_board, round, mark, wins, x_pos, o_pos)
    result = p1.moves.include?(move)
    assert_equal(true, result)
  end

  def test_2_verify_random_takes_last_open_position
    game = Game.new
    p1 = PlayerRandom.new
    game.board.game_board = ["X", "O", "", "X", "O", "O", "O", "X", "X"]
    round = 8
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(game.board.game_board, round, mark, wins, x_pos, o_pos)
    assert_equal("t3", result)
  end

end