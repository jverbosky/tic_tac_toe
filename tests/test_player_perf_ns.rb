# be sure to use the unit test versions of attr_ in board.rb and game.rb
# - attr_accessor in /board/board.rb
# - attr_reader in /game/game.rb

require "minitest/autorun"
require_relative "../players/player_perf_ns.rb"
require_relative "../game/game.rb"

class TestPlayerPerfectNS < Minitest::Test

  def test_1_round_1_X_takes_a_random_corner
    game = Game.new
    p1 = PlayerPerfectNS.new
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m2", result)
  end

  def test_2_round_2_O_takes_center
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "", "", "", "", "", "", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m2", result)
  end

  def test_3_round_2_X_took_center_O_takes_a_random_corner
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["", "", "", "", "X", "", "", "", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    corners = ["t1", "t3", "b1", "b3"]
    move = p1.get_move(wins, x_pos, o_pos, mark)
    result = corners.include? move
    assert_equal(true, result)
  end

  def test_4_round_2_X_took_edge_O_takes_center_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["", "X", "", "", "", "", "", "", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m2", result)
  end

  def test_5_round_2_X_took_edge_O_takes_center_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["", "", "", "X", "", "", "", "", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m2", result)
  end

  def test_6_round_3_perfect_O_took_center_X_takes_open_corner_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "", "", "O", "", "", "", ""]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    corners = ["t3", "b1", "b3"]
    move = p1.get_move(wins, x_pos, o_pos, mark)
    result = corners.include? move
    assert_equal(true, result)
  end

  def test_7_round_3_perfect_O_took_center_X_takes_open_corner_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["", "", "X", "", "O", "", "", "", ""]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    corners = ["t1", "b1", "b3"]
    move = p1.get_move(wins, x_pos, o_pos, mark)
    result = corners.include? move
    assert_equal(true, result)
  end

  def test_8_round_3_perfect_O_took_center_X_takes_open_corner_v3
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["", "", "", "", "O", "", "X", "", ""]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    corners = ["t1", "t3", "b3"]
    move = p1.get_move(wins, x_pos, o_pos, mark)
    result = corners.include? move
    assert_equal(true, result)
  end

  def test_9_round_3_perfect_O_took_center_X_takes_open_corner_v4
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["", "", "", "", "O", "", "", "", "X"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    corners = ["t1", "t3", "b1"]
    move = p1.get_move(wins, x_pos, o_pos, mark)
    result = corners.include? move
    assert_equal(true, result)
  end

  def test_10_round_3_O_took_edge_X_takes_center
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "", "", "", "", "", "O", ""]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m2", result)
  end

  def test_11_round_3_O_took_corner_X_takes_center_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "O", "", "", "", "", "", ""]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m2", result)
  end

  def test_12_round_3_O_took_corner_X_takes_center_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["O", "", "X", "", "", "", "", "", ""]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m2", result)
  end

  def test_13_round_3_O_took_opposite_corner_X_takes_center_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "", "", "", "", "", "", "O"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m2", result)
  end

  def test_14_round_3_O_took_opposite_corner_X_takes_center_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["", "", "X", "", "", "", "O", "", ""]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m2", result)
  end

  def test_15_round_4_perfect_X_took_opposite_corner_O_forces_block_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "", "", "O", "", "", "", "X"]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    edges = ["t2", "m1", "m3", "b2"]
    move = p1.get_move(wins, x_pos, o_pos, mark)
    result = edges.include? move
    assert_equal(true, result)
  end

  def test_16_round_4_perfect_X_took_opposite_corner_O_forces_block_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["", "", "X", "", "O", "", "X", "", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    edges = ["t2", "m1", "m3", "b2"]
    move = p1.get_move(wins, x_pos, o_pos, mark)
    result = edges.include? move
    assert_equal(true, result)
  end

  def test_17_round_4_X_took_corner_and_adjacent_corner_O_blocks_at_edge_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "X", "", "O", "", "", "", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("t2", result)
  end

  def test_18_round_4_X_took_corner_and_adjacent_corner_O_blocks_at_edge_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["", "", "X", "", "O", "", "", "", "X"]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m3", result)
  end

  def test_19_round_4_X_took_corner_and_adjacent_edge_O_blocks_at_adjacent_corner_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "X", "", "", "O", "", "", "", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("t3", result)
  end

  def test_20_round_4_X_took_corner_and_adjacent_edge_O_blocks_at_adjacent_corner_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["", "", "X", "", "O", "X", "", "", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b3", result)
  end

  def test_21_round_4_X_took_corner_and_non_adjacent_edge_O_blocks_fork_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "", "", "O", "", "", "X", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b1", result)
  end

  def test_22_round_4_X_took_corner_and_non_adjacent_edge_O_blocks_fork_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "", "", "O", "X", "", "", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("t3", result)
  end

  def test_23_round_4_X_took_center_and_corner_O_blocks_at_opposite_corner_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["O", "", "X", "", "X", "", "", "", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b1", result)
  end

  def test_24_round_4_X_took_center_and_corner_O_blocks_at_opposite_corner_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["", "", "O", "", "X", "", "", "", "X"]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("t1", result)
  end

  def test_25_round_4_X_took_center_and_corner_opposite_O_O_forces_block_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["O", "", "", "", "X", "", "", "", "X"]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    edges = ["t3", "b1"]
    move = p1.get_move(wins, x_pos, o_pos, mark)
    result = edges.include? move
    assert_equal(true, result)
  end

  def test_26_round_4_X_took_center_and_corner_opposite_O_O_forces_block_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["", "", "X", "", "X", "", "O", "", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    edges = ["t1", "b3"]
    move = p1.get_move(wins, x_pos, o_pos, mark)
    result = edges.include? move
    assert_equal(true, result)
  end

  def test_27_round_4_X_took_center_and_edge_O_blocks_at_opposite_edge_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["O", "", "", "X", "X", "", "", "", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m3", result)
  end

  def test_28_round_4_X_took_center_and_edge_O_blocks_at_opposite_edge_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["O", "X", "", "", "X", "", "", "", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b2", result)
  end

  def test_29_round_4_X_took_edge_and_opposite_edge_O_takes_corner_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["", "X", "", "", "O", "", "", "X", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    corners = ["t1", "t3", "b1", "b3"]
    move = p1.get_move(wins, x_pos, o_pos, mark)
    result = corners.include? move
    assert_equal(true, result)
  end

  def test_30_round_4_X_took_edge_and_opposite_edge_O_takes_corner_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["", "", "", "X", "O", "X", "", "", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    corners = ["t1", "t3", "b1", "b3"]
    move = p1.get_move(wins, x_pos, o_pos, mark)
    result = corners.include? move
    assert_equal(true, result)
  end

  def test_31_round_4_X_took_edge_and_adjacent_edge_O_takes_corner_between_X_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["", "X", "", "", "O", "X", "", "", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("t3", result)
  end

  def test_32_round_4_X_took_edge_and_adjacent_edge_O_takes_corner_between_X_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["", "", "", "", "O", "X", "", "X", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b3", result)
  end

  def test_33_round_5_perfect_O_took_edge_X_blocks_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "O", "", "", "O", "", "", "", "X"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b2", result)
  end

  def test_34_round_5_perfect_O_took_edge_X_blocks_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "", "O", "O", "", "", "", "X"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m3", result)
  end

  def test_35_round_5_perfect_O_took_edge_X_blocks_v3
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "", "", "O", "O", "", "", "X"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m1", result)
  end

  def test_36_round_5_perfect_O_took_edge_X_blocks_v3
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "", "", "O", "", "", "O", "X"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("t2", result)
  end

  def test_37_round_5_O_took_center_after_corner_X_blocks_and_sets_2_wins
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "O", "", "O", "", "", "", "X"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b1", result)
  end

  def test_38_round_5_O_took_edge_after_opposite_corner_X_makes_fork
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "O", "X", "", "", "", "", "", "O"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b1", result)
  end

  def test_39_round_5_O_took_corner_after_center_X_block_and_sets_2_wins
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "", "", "O", "", "O", "", "X"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("t3", result)
  end

  def test_40_round_5_O_took_opposite_corner_and_adjacent_edge_X_block_and_sets_2_wins_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "", "", "X", "O", "", "", "O"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("t3", result)
  end

  def test_41_round_5_O_took_opposite_corner_and_adjacent_edge_X_block_and_sets_2_wins_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "", "", "X", "", "", "O", "O"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b1", result)
  end

  def test_42_round_5_O_took_adjacent_corner_and_adjacent_edge_X_wins
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["", "", "X", "", "", "O", "X", "", "O"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m2", result)
  end

  def test_43_round_5_added_failsafe_logic_after_random_testing_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "X", "", "", "", "O", "", "O"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("t2", result)
  end

  def test_44_round_5_merged_edge_logic_into_block_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["", "", "O", "O", "X", "", "", "", "X"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("t1", result)
  end

  def test_45_round_5_merged_edge_logic_into_block_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "O", "O", "X", "", "", "", ""]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b3", result)
  end

  def test_46_round_6_perfect_X_blocks_at_edge_O_blocks_at_corner_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "O", "", "", "O", "", "", "X", "X"]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b1", result)
  end

  def test_47_round_6_perfect_X_blocks_at_edge_O_blocks_at_corner_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "X", "", "", "O", "", "", "O", "X"]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("t3", result)
  end

  def test_48_round_6_perfect_X_blocks_at_edge_O_blocks_at_corner_v3
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["", "", "X", "O", "O", "X", "X", "", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b3", result)
  end

  def test_49_round_6_perfect_X_blocks_at_edge_O_blocks_at_corner_v4
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["", "", "X", "X", "O", "O", "X", "", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("t1", result)
  end

  def test_50_round_6_X_took_adjacent_corners_and_opposite_edge_O_forces_block_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "O", "X", "", "O", "", "", "X", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    edges = ["m1", "m3"]
    move = p1.get_move(wins, x_pos, o_pos, mark)
    result = edges.include? move
    assert_equal(true, result)
  end

  def test_51_round_6_X_took_adjacent_corners_and_opposite_edge_O_forces_block_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["", "", "X", "X", "O", "O", "", "", "X"]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    edges = ["t2", "b2"]
    move = p1.get_move(wins, x_pos, o_pos, mark)
    result = edges.include? move
    assert_equal(true, result)
  end

  def test_52_round_6_X_took_corner_adjacent_edge_and_adjacent_corner_O_blocks_at_edge_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "X", "O", "", "O", "", "X", "", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m1", result)
  end

  def test_53_round_6_X_took_corner_adjacent_edge_and_adjacent_corner_O_blocks_at_edge_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "X", "", "O", "X", "", "", "O"]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("t2", result)
  end

  def test_54_round_6_X_took_adjacent_edges_and_adjacent_corner_O_blocks_at_corner_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "", "X", "O", "O", "", "X", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b1", result)
  end

  def test_55_round_6_X_took_adjacent_edges_and_adjacent_corner_O_blocks_at_corner_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "X", "", "", "O", "X", "", "O", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("t3", result)
  end

  def test_56_round_6_X_took_corner_center_and_opposite_edge_O_blocks_at_edge_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["O", "", "X", "X", "X", "", "O", "", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m3", result)
  end

  def test_57_round_6_X_took_corner_center_and_opposite_edge_O_blocks_at_edge_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["O", "X", "O", "", "X", "", "X", "", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b2", result)
  end

  def test_58_round_6_X_took_corner_and_adjacent_edges_O_blocks_at_edge_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["O", "X", "", "X", "X", "O", "", "", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b2", result)
  end

  def test_59_round_6_X_took_corner_and_adjacent_edges_O_blocks_at_edge_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["O", "X", "", "X", "X", "", "", "O", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m3", result)
  end

  def test_60_round_6_X_took_edge_adjacent_corner_and_center_O_blocks_at_corner_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["O", "", "", "X", "X", "O", "X", "", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("t3", result)
  end

  def test_61_round_6_X_took_edge_adjacent_corner_and_center_O_blocks_at_corner_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["O", "X", "X", "", "X", "", "", "O", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b1", result)
  end

  def test_62_round_6_X_took_corner_adjacent_edge_and_opposite_edge_O_blocks_at_corner_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["O", "X", "", "", "O", "", "", "X", "X"]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b1", result)
  end

  def test_63_round_6_X_took_corner_adjacent_edge_and_opposite_edge_O_blocks_at_corner_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "", "X", "O", "X", "", "", "O"]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b1", result)
  end

  def test_64_round_6_X_took_adjacent_edges_and_opposite_corner_O_takes_random_corner_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["", "X", "O", "", "O", "X", "X", "", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    positions = ["t1", "b3"]
    move = p1.get_move(wins, x_pos, o_pos, mark)
    result = positions.include? move
    assert_equal(true, result)
  end

  def test_65_round_6_X_took_adjacent_edges_and_opposite_corner_O_takes_random_corner_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "", "", "O", "X", "", "X", "O"]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    positions = ["t3", "b1"]
    move = p1.get_move(wins, x_pos, o_pos, mark)
    result = positions.include? move
    assert_equal(true, result)
  end

  def test_66_round_7_O_blocks_at_m1_X_wins
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "O", "O", "O", "", "X", "", "X"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b2", result)
  end

  def test_67_round_7_O_blocks_at_b2_X_wins
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "O", "", "O", "", "X", "O", "X"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m1", result)
  end

  def test_68_round_7_O_blocks_at_m1_X_wins
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "O", "X", "O", "", "", "X", "", "O"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m2", result)
  end

  def test_69_round_7_O_blocks_at_m2_X_wins
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "O", "X", "", "O", "", "X", "", "O"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m1", result)
  end

  def test_70_round_7_O_blocks_at_t2_X_wins
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "O", "X", "", "O", "", "O", "", "X"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m3", result)
  end

  def test_71_round_7_O_blocks_at_m3_X_wins
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "X", "", "O", "O", "O", "", "X"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("t2", result)
  end

  def test_72_round_7_X_blocks_O_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "O", "", "", "O", "", "O", "X", "X"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("t3", result)
  end

  def test_73_round_7_X_blocks_O_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "O", "O", "O", "X", "", "", "X"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b1", result)
  end

  def test_74_round_7_X_blocks_O_v3
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["", "", "X", "O", "O", "X", "X", "", "O"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("t1", result)
  end

  def test_75_round_7_X_blocks_O_v4
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["O", "", "X", "X", "O", "O", "X", "", ""]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b3", result)
  end

  def test_76_round_7_multiple_X_blocks_O
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["O", "O", "", "X", "O", "X", "X", "", ""]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    blocks = ["t3", "b2", "b3"]
    move = p1.get_move(wins, x_pos, o_pos, mark)
    result = blocks.include? move
    assert_equal(true, result)
  end

  def test_77_round_7_multiple_X_wins
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "X", "", "O", "X", "O", "O", "", ""]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    winners = ["t3", "b2", "b3"]
    move = p1.get_move(wins, x_pos, o_pos, mark)
    result = winners.include? move
    assert_equal(true, result)
  end

  def test_78_round_6_perfect_X_blocks_at_edge_O_blocks_at_corner_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "O", "X", "", "O", "", "O", "X", "X"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m3", result)
  end

  def test_79_round_6_perfect_X_blocks_at_edge_O_blocks_at_corner_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "X", "O", "", "O", "", "X", "O", "X"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m1", result)
  end

  def test_80_round_8_perfect_X_blocks_at_edge_O_blocks_at_corner_v3
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "X", "O", "O", "X", "X", "", "O"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("t2", result)
  end

  def test_81_round_8_perfect_X_blocks_at_corner_O_blocks_at_edge_v4
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["O", "", "X", "X", "O", "O", "X", "", "X"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b2", result)
  end

  def test_82_round_8_X_blocked_at_edge_O_blocks_at_corner_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "O", "X", "O", "O", "X", "", "X", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b3", result)
  end

  def test_83_round_8_X_blocked_at_edge_O_blocks_at_corner_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["", "X", "X", "X", "O", "O", "", "O", "X"]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("t1", result)
  end

  def test_84_round_8_X_blocked_at_edge_O_takes_random_open_position_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "X", "O", "O", "O", "X", "X", "", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    open_pos = ["b2", "b3"]
    move = p1.get_move(wins, x_pos, o_pos, mark)
    result = open_pos.include? move
    assert_equal(true, result)
  end

  def test_85_round_8_X_blocked_at_edge_O_takes_random_open_position_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "O", "X", "", "O", "X", "", "X", "O"]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    open_pos = ["m1", "b1"]
    move = p1.get_move(wins, x_pos, o_pos, mark)
    result = open_pos.include? move
    assert_equal(true, result)
  end

  def test_86_round_8_X_blocked_at_corner_O_blocks_at_edge_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "X", "X", "O", "O", "O", "X", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("t2", result)
  end

  def test_87_round_8_X_blocked_at_corner_O_blocks_at_edge_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "X", "O", "", "O", "X", "X", "O", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m1", result)
  end

  def test_88_round_8_X_took_random_open_edge_O_blocks_at_edge_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["O", "", "X", "X", "X", "O", "O", "X", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("t2", result)
  end

  def test_89_round_8_X_took_random_open_edge_O_blocks_at_edge_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["O", "X", "O", "", "X", "X", "", "O", "X"]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m1", result)
  end

  def test_90_round_8_X_took_random_non_opposite_corner_O_blocks_at_corner_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["O", "X", "", "X", "X", "O", "X", "O", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("t3", result)
  end

  def test_91_round_8_X_took_random_non_opposite_corner_O_blocks_at_corner_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["O", "X", "X", "X", "X", "O", "", "O", ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b1", result)
  end

  def test_92_round_8_X_blocked_at_corner_O_blocks_at_corner_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["O", "", "O", "X", "X", "O", "X", "", "X"]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("t2", result)
  end

  def test_93_round_8_X_blocked_at_corner_O_blocks_at_corner_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["O", "X", "X", "", "X", "", "O", "O", "X"]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m1", result)
  end

  def test_94_round_8_X_blocked_at_edge_or_corner_O_wins_via_fork_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["O", "X", "", "X", "O", "", "O", "X", "X"]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("t3", result)
  end

  def test_95_round_8_X_blocked_at_edge_or_corner_O_wins_via_fork_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "X", "X", "O", "X", "O", "", "O"]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b2", result)
  end

  def test_96_round_8_X_blocked_at_corner_O_blocks_at_edge_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "X", "O", "", "O", "X", "X", "", "O"]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m1", result)
  end

  def test_97_round_8_X_blocked_at_corner_O_blocks_at_edge_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "O", "", "O", "X", "X", "X", "O"]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m1", result)
  end

  def test_98_round_9_X_ties_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "O", "X", "", "O", "O", "O", "X", "X"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("m1", result)
  end

  def test_99_round_9_X_ties_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "O", "O", "O", "X", "X", "O", "X"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("t2", result)
  end

  def test_100_round_9_X_ties_v3
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "O", "X", "O", "O", "X", "X", "", "O"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b2", result)
  end

  def test_101_round_9_X_ties_v4
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["O", "", "X", "X", "O", "O", "X", "O", "X"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("t2", result)
  end

  def test_102_round_9_X_takes_last_open_position_no_win_or_block_v1
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "O", "X", "O", "O", "X", "", "X", "O"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b1", result)
  end

  def test_103_round_9_X_takes_last_open_position_no_win_or_block_v2
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["O", "X", "X", "X", "O", "O", "", "O", "X"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b1", result)
  end

  def test_104_X_takes_win_over_block
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["O", "O", "", "", "", "", "X", "", "X"]
    mark = "X"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    result = p1.get_move(wins, x_pos, o_pos, mark)
    assert_equal("b2", result)
  end

  def test_105_O_blocks_multiple_forks
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["", "X", "", "O", "O", "X", "X", "" ""]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    force_block = ["t1", "b3"]
    move = p1.get_move(wins, x_pos, o_pos, mark)
    result = force_block.include? move
    assert_equal(true, result)
  end

  def test_106_O_blocks_multiple_forks
    game = Game.new
    p1 = PlayerPerfectNS.new
    game.board.game_board = ["X", "", "", "", "X", "", "", "", "O"]
    mark = "O"
    wins = game.win.wins
    x_pos = game.board.get_x
    o_pos = game.board.get_o
    force_block = ["t3", "b1"]
    move = p1.get_move(wins, x_pos, o_pos, mark)
    result = force_block.include? move
    assert_equal(true, result)
  end

end