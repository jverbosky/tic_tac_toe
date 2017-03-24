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

  def test_14_verify_round_not_incremented_if_invalid_Human_move
    game = Game.new
    game.round = 3
    game.board.game_board = ["X", "", "", "", "", "", "", "", ""]
    game.p1_type = "Human"
    game.p2_type = "Perfect"
    move = "t1"
    game.make_move(move)
    result = game.round
    assert_equal(3, result)
  end

  def test_15_verify_round_incremented_if_valid_AI_move
    game = Game.new
    player_type = {"p1_type"=>"Human", "p2_type"=>"Sequential"}
    move = ""
    game.board.game_board = ["X", "", "", "", "", "", "", "", ""]
    game.round = 2
    game.select_players(player_type)
    game.p1_type = "Human"
    game.p2_type = "Sequential"
    game.make_move(move)
    result = game.round
    assert_equal(3, result)
  end

  def test_16_verify_move_instance_variable_updated_by_human_move
    game = Game.new
    game.human_move("t1")
    result = game.move
    assert_equal("t1", result)
  end

  def test_17_verify_move_instance_variable_updated_by_perfect_AI_move
    game = Game.new
    player_type = {"p1_type"=>"Human", "p2_type"=>"Perfect"}
    game.board.game_board = ["X", "", "", "", "", "", "", "", ""]
    game.round = 2
    game.select_players(player_type)
    game.set_players
    game.m_current = "O"
    game.ai_move
    result = game.move
    assert_equal("m2", result)
  end

  def test_18_verify_move_instance_variable_updated_by_unbeatable_AI_move
    game = Game.new
    player_type = {"p1_type"=>"Human", "p2_type"=>"Unbeatable"}
    game.board.game_board = ["X", "", "", "", "", "", "", "", ""]
    game.round = 2
    game.select_players(player_type)
    game.set_players
    game.m_current = "O"
    game.ai_move
    result = game.move
    assert_equal("m2", result)
  end

  def test_19_verify_move_instance_variable_updated_by_sequential_AI_move
    game = Game.new
    player_type = {"p1_type"=>"Human", "p2_type"=>"Sequential"}
    game.board.game_board = ["X", "", "", "", "", "", "", "", ""]
    game.round = 2
    game.select_players(player_type)
    game.set_players
    game.m_current = "O"
    game.ai_move
    result = game.move
    assert_equal("t2", result)
  end

  def test_20_verify_move_instance_variable_updated_by_random_AI_move
    game = Game.new
    player_type = {"p1_type"=>"Human", "p2_type"=>"Random"}
    game.board.game_board = ["X", "X", "O", "O", "X", "X", "O", "", ""]
    game.round = 2
    game.select_players(player_type)
    game.set_players
    game.m_current = "O"
    game.ai_move
    moves = ["b2", "b3"]
    result = moves.include? game.move
    assert_equal(true, result)
  end

  def test_21_verify_valid_move_returns_true
    game = Game.new
    game.board.game_board = ["X", "X", "O", "O", "X", "X", "O", "", ""]
    game.round = 8
    game.move = "b3"
    game.board_index = 7
    game.pt_current = "Sequential"
    game.m_current = "O"
    game.pt_next = "Human"
    game.m_next = "X"
    result = game.valid_move?
    assert_equal(true, result)
  end

  def test_22_verify_valid_move_updates_board
    game = Game.new
    game.board.game_board = ["X", "X", "O", "O", "X", "X", "O", "", ""]
    game.round = 8
    game.move = "b3"
    game.board_index = 7
    game.pt_current = "Sequential"
    game.m_current = "O"
    game.pt_next = "Human"
    game.m_next = "X"
    game.valid_move?
    result = ["X", "X", "O", "O", "X", "X", "O", "O", ""]
    assert_equal(game.board.game_board, result)
  end

  def test_23_verify_valid_move_updates_messaging_feedback
    game = Game.new
    game.board.game_board = ["X", "X", "O", "O", "X", "X", "O", "", ""]
    game.round = 8
    game.move = "b3"
    game.board_index = 7
    game.pt_current = "Sequential"
    game.m_current = "O"
    game.pt_next = "Human"
    game.m_next = "X"
    game.valid_move?
    result = "Sequential O took b3 in round 8."
    assert_equal(game.messaging.feedback, result)
  end

  def test_24_verify_valid_move_updates_messaging_prompt
    game = Game.new
    game.board.game_board = ["X", "X", "O", "O", "X", "X", "O", "", ""]
    game.round = 8
    game.move = "b3"
    game.board_index = 7
    game.pt_current = "Sequential"
    game.m_current = "O"
    game.pt_next = "Human"
    game.m_next = "X"
    game.valid_move?
    result = "Press <b>Next</b> for Human X's move."
    assert_equal(game.messaging.prompt, result)
  end

  def test_25_verify_invalid_move_returns_false
    game = Game.new
    game.board.game_board = ["X", "X", "O", "O", "X", "X", "O", "", ""]
    game.round = 8
    game.move = "t1"
    game.board_index = 0
    game.pt_current = "Human"
    game.m_current = "O"
    game.pt_next = "Random"
    game.m_next = "X"
    result = game.valid_move?
    assert_equal(false, result)
  end

  def test_26_verify_invalid_move_updates_messaging_feedback
    game = Game.new
    game.board.game_board = ["X", "X", "O", "O", "X", "X", "O", "", ""]
    game.round = 8
    game.move = "t1"
    game.board_index = 0
    game.pt_current = "Human"
    game.m_current = "O"
    game.pt_next = "Random"
    game.m_next = "X"
    game.valid_move?
    result = "That position isn't open. Try again Human O."
    assert_equal(game.messaging.feedback, result)
  end

  def test_27_verify_game_over_if_X_won
    game = Game.new
    game.board.game_board = ["X", "O", "X", "O", "O", "X", "", "", "X"]
    result = game.game_over?
    assert_equal(true, result)
  end

  def test_28_verify_game_over_if_O_won
    game = Game.new
    game.board.game_board = ["X", "O", "X", "O", "O", "O", "X", "", "X"]
    result = game.game_over?
    assert_equal(true, result)
  end

  def test_29_verify_game_over_if_board_full
    game = Game.new
    game.board.game_board = ["X", "X", "O", "O", "O", "X", "X", "X", "O"]
    result = game.game_over?
    assert_equal(true, result)
  end

  def test_30_verify_end_game_returns_X_if_X_wins
    game = Game.new
    $x_score = 0
    game.board.game_board = ["X", "O", "X", "O", "O", "X", "", "", "X"]
    game.game_over?
    game.messaging.win = [2, 5, 8]
    result = game.end_game
    assert_equal("X", result)
  end

  def test_31_verify_end_game_increments_x_score_if_X_wins
    game = Game.new
    $x_score = 0
    game.board.game_board = ["X", "O", "X", "O", "O", "X", "", "", "X"]
    game.game_over?
    game.messaging.win = [2, 5, 8]
    game.end_game
    result = $x_score
    assert_equal(1, result)
  end

  def test_32_verify_end_game_returns_O_if_O_wins
    game = Game.new
    $o_score = 0
    game.board.game_board = ["X", "O", "X", "O", "O", "O", "X", "", "X"]
    game.game_over?
    game.messaging.win = [3, 4, 5]
    result = game.end_game
    assert_equal("O", result)
  end

  def test_33_verify_end_game_increments_o_score_if_O_wins
    game = Game.new
    $o_score = 0
    game.board.game_board = ["X", "O", "X", "O", "O", "O", "X", "", "X"]
    game.game_over?
    game.messaging.win = [3, 4, 5]
    game.end_game
    result = $o_score
    assert_equal(1, result)
  end

  def test_34_verify_end_game_returns_tie_if_board_full_and_no_wins
    game = Game.new
    $x_score = 0
    game.board.game_board = ["X", "X", "O", "O", "O", "X", "X", "X", "O"]
    game.game_over?
    game.messaging.win = []
    result = game.end_game
    assert_equal("tie", result)
  end

end