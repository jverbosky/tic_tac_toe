require "minitest/autorun"
require_relative "../game/messaging.rb"

class TestPosition < Minitest::Test

  def test_1_validate_feedback_for_valid_move_Human_X
    messaging = Messaging.new
    round = 1
    move = "t3"
    pt_current = "Human"
    m_current = "X"
    pt_next = "Perfect"
    m_next = "O"
    messaging.valid_move(round, move, pt_current, m_current, pt_next, m_next)
    result = messaging.feedback
    assert_equal("Human X took t3 in round 1.", result)
  end

  def test_2_validate_prompt_for_valid_move_Human_X
    messaging = Messaging.new
    round = 1
    move = "t3"
    pt_current = "Human"
    m_current = "X"
    pt_next = "Perfect"
    m_next = "O"
    messaging.valid_move(round, move, pt_current, m_current, pt_next, m_next)
    result = messaging.prompt
    assert_equal("Press <b>Next</b> for Perfect O's move.", result)
  end

  def test_3_validate_feedback_for_valid_move_Perfect_O
    messaging = Messaging.new
    round = 6
    move = "b1"
    pt_current = "Perfect"
    m_current = "O"
    pt_next = "Human"
    m_next = "X"
    messaging.valid_move(round, move, pt_current, m_current, pt_next, m_next)
    result = messaging.feedback
    assert_equal("Perfect O took b1 in round 6.", result)
  end

  def test_4_validate_prompt_for_valid_move_Perfect_O
    messaging = Messaging.new
    round = 6
    move = "b1"
    pt_current = "Perfect"
    m_current = "O"
    pt_next = "Human"
    m_next = "X"
    messaging.valid_move(round, move, pt_current, m_current, pt_next, m_next)
    result = messaging.prompt
    assert_equal("Press <b>Next</b> for Human X's move.", result)
  end

  def test_5_validate_feedback_for_invalid_move_Human_X
    messaging = Messaging.new
    m_current = "X"
    messaging.invalid_move(m_current)
    result = messaging.feedback
    assert_equal("That position isn't open. Try again Human X.", result)
  end

  def test_6_validate_feedback_for_invalid_move_Human_O
    messaging = Messaging.new
    m_current = "O"
    messaging.invalid_move(m_current)
    result = messaging.feedback
    assert_equal("That position isn't open. Try again Human O.", result)
  end

  def test_7_validate_round_1_messaging_Human_X
    messaging = Messaging.new
    round = 1
    mark = "X"
    result = messaging.human_messaging(round, mark)
    assert_equal("It's Human X's move!", result)
  end

  def test_8_validate_round_2_messaging_Human_O
    messaging = Messaging.new
    round = 2
    mark = "O"
    result = messaging.human_messaging(round, mark)
    assert_equal("It's Human O's move!", result)
  end

  def test_9_validate_round_3_messaging_Human_X
    messaging = Messaging.new
    round = 3
    mark = "X"
    result = messaging.human_messaging(round, mark)
    assert_equal("It's Human X's move again!", result)
  end

  def test_10_validate_round_4_messaging_Human_O
    messaging = Messaging.new
    round = 4
    mark = "O"
    result = messaging.human_messaging(round, mark)
    assert_equal("It's Human O's move again!", result)
  end

  def test_11_validate_endgame_results_Human_X_win
    messaging = Messaging.new
    p1_type = "Human"
    p2_type = "Perfect"
    winner = "X"
    messaging.win = "t1, m2, b3"
    result = messaging.display_results(p1_type, p2_type, winner)
    assert_equal("Human X won the game!<br>The winning positions were: t1, m2, b3", result)
  end

  def test_12_validate_endgame_results_Perfect_O_win
    messaging = Messaging.new
    p1_type = "Human"
    p2_type = "Perfect"
    winner = "O"
    messaging.win = "m1, m2, m3"
    result = messaging.display_results(p1_type, p2_type, winner)
    assert_equal("Perfect O won the game!<br>The winning positions were: m1, m2, m3", result)
  end

  def test_13_validate_endgame_results_tie
    messaging = Messaging.new
    p1_type = "Human"
    p2_type = "Perfect"
    winner = "tie"
    result = messaging.display_results(p1_type, p2_type, winner)
    assert_equal("It was a tie!", result)
  end

end