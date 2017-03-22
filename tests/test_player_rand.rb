# be sure to use the unit test versions of attr_ in board.rb and game.rb
# - attr_accessor in board.rb
# - attr_reader in game.rb
# - attr_reader in player_rand.rb

require "minitest/autorun"
require_relative "../players/player_rand.rb"
require_relative "../game/game.rb"

class TestPlayerRandom < Minitest::Test

  def test_1_verify_random_move
    game = Game.new
    p1 = PlayerRandom.new
    move = p1.get_move(game.board.game_board)
    result = p1.moves.include?(move)
    assert_equal(true, result)
  end

  def test_2_verify_random_takes_last_open_position
    game = Game.new
    p1 = PlayerRandom.new
    game.board.game_board = ["X", "O", "", "X", "O", "O", "O", "X", "X"]
    result = p1.get_move(game.board.game_board)
    assert_equal("t3", result)
  end

end