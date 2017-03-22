# be sure to use the unit test versions of attr_ in board.rb and game.rb
# - attr_accessor in board.rb
# - attr_reader in game.rb

require "minitest/autorun"
require_relative "../game/game.rb"

class TestPosition < Minitest::Test

  def test_1_verify_board_output_new_game
    game = Game.new
    game.board.game_board = ["", "", "", "", "", "", "", "", ""]
    result = game.output_board
    assert_equal([["", "", ""], ["", "", ""], ["", "", ""]], result)
  end

  def test_2_verify_board_output_game_in_progress
    game = Game.new
    game.board.game_board = ["X", "", "", "", "O", "", "", "O", "X"]
    result = game.output_board
    assert_equal([["X", "", ""], ["", "O", ""], ["", "O", "X"]], result)
  end

  def test_3_verify_player_1_type_updating_correctly
    game = Game.new
    player_type = {"p1_type"=>"Random", "p2_type"=>"Perfect"}
    game.select_players(player_type)
    result = game.p1_type
    assert_equal("Random", result)
  end

  def test_4_verify_player_2_type_updating_correctly
    game = Game.new
    player_type = {"p1_type"=>"Random", "p2_type"=>"Perfect"}
    game.select_players(player_type)
    result = game.p2_type
    assert_equal("Perfect", result)
  end

  def test_5_verify_current_player_type_updating_correctly_round_1
    game = Game.new
    game.round = 1
    game.p1_type = "Human"
    game.p2_type = "Perfect"
    game.set_players
    result = game.pt_current
    assert_equal("Human", result)
  end

  def test_6_verify_next_player_type_updating_correctly_round_1
    game = Game.new
    game.round = 1
    game.p1_type = "Human"
    game.p2_type = "Perfect"
    game.set_players
    result = game.pt_next
    assert_equal("Perfect", result)
  end

  def test_7_verify_current_mark_updating_correctly_round_1
    game = Game.new
    game.round = 1
    game.p1_type = "Human"
    game.p2_type = "Perfect"
    game.set_players
    result = game.m_current
    assert_equal("X", result)
  end

  def test_8_verify_next_mark_updating_correctly_round_1
    game = Game.new
    game.round = 1
    game.p1_type = "Human"
    game.p2_type = "Perfect"
    game.set_players
    result = game.m_next
    assert_equal("O", result)
  end

  def test_9_verify_current_player_type_updating_correctly_round_2
    game = Game.new
    game.round = 2
    game.p1_type = "Human"
    game.p2_type = "Perfect"
    game.set_players
    result = game.pt_current
    assert_equal("Perfect", result)
  end

  def test_10_verify_next_player_type_updating_correctly_round_2
    game = Game.new
    game.round = 2
    game.p1_type = "Human"
    game.p2_type = "Perfect"
    game.set_players
    result = game.pt_next
    assert_equal("Human", result)
  end

  def test_11_verify_current_mark_updating_correctly_round_2
    game = Game.new
    game.round = 2
    game.p1_type = "Human"
    game.p2_type = "Perfect"
    game.set_players
    result = game.m_current
    assert_equal("O", result)
  end

  def test_12_verify_next_mark_updating_correctly_round_2
    game = Game.new
    game.round = 2
    game.p1_type = "Human"
    game.p2_type = "Perfect"
    game.set_players
    result = game.m_next
    assert_equal("X", result)
  end

  def test_13_verify_round_incremented_if_valid_Human_move
    game = Game.new
    game.round = 1
    game.p1_type = "Human"
    game.p2_type = "Perfect"
    move = "t1"
    game.make_move(move)
    result = game.round
    assert_equal(2, result)
  end

  # def make_move(move)
  #   set_players  # update @player_, @player_type_ and @mark_ variables for current round
  #   @pt_current == "Human" ? human_move(move) : ai_move  # move() call based on player type
  #   @board_index = @position.get_index(@move)  # convert human friendly move to board index value
  #   @round += 1 if valid_move?  # if the move is valid, increment the @round counter
  # end

  def test_14_verify_round_incremented_if_valid_AI_move
    game = Game.new
    game.board.game_board = ["X", "", "", "", "", "", "", "", ""]
    game.round = 2
    game.p1_type = "Human"
    game.p2_type = "Sequential"
    move = ""
    game.make_move(move)
    result = game.round
    assert_equal(3, result)
  end

end