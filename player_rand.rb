require_relative "board.rb"

class PlayerRandom

  attr_reader :moves

  def initialize
    @moves = ["t1", "t2", "t3", "m1", "m2", "m3", "b1", "b2", "b3"]
  end

  def get_move(game_board)  # added round argument as it's required for PlayerSequential get_move method
    position = @moves.sample
  end

end

# Sandbox testing
# p1 = PlayerRandom.new
# move = p1.get_move
# puts move
# result = p1.moves.include?(move)
# puts result
