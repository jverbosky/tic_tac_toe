require_relative "../board/board.rb"

# class for computer player that randomly places mark
class PlayerRandom

  attr_reader :moves

  def initialize
    @moves = ["t1", "t2", "t3", "m1", "m2", "m3", "b1", "b2", "b3"]
  end

  def get_move(game_board, round, mark, wins, x_pos, o_pos)
    position = game_board.each_index.select{ |index| game_board[index] == "" }
    move = @moves[position.sample]
  end

end

# Sandbox testing
# p1 = PlayerRandom.new
# b = ["O", "X", "O", "X", "O", "X", "O", "X", ""]
# r = 8
# m = "X"
# w = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
# x = [1, 3, 5, 7]
# o = [0, 2, 4, 6]
# move = p1.get_move(b, r, m, w, x, o)
# puts move
# result = p1.moves.include?(move)
# puts result