class PlayerRandom

  attr_reader :moves

  def initialize
    @moves = ["t1", "t2", "t3", "m1", "m2", "m3", "b1", "b2", "b3"]
  end

  def move
    position = @moves.sample
  end

end

# Sandbox testing
p1 = PlayerRandom.new
move = p1.move
puts move
result = p1.moves.include?(move)
puts result
