require_relative "../board/board.rb"

# class for computer player that places mark on next open position
class PlayerSequential

  def initialize
    @moves = ["t1", "t2", "t3", "m1", "m2", "m3", "b1", "b2", "b3"]
  end

  def get_move(game_board)
    position = game_board.index("")
    move = @moves[position]
  end

end