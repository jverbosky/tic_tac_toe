require_relative "../board/board.rb"

# class for computer player that randomly places mark
class PlayerRandom

  def initialize
    @moves = ["t1", "t2", "t3", "m1", "m2", "m3", "b1", "b2", "b3"]
  end

  def get_move(game_board, round, mark, wins, x_pos, o_pos)
    position = game_board.each_index.select{ |index| game_board[index] == "" }
    move = @moves[position.sample]
  end

end