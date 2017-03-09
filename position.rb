# class to translate player moves into board array positions
# - allows player to specify plain language positions instead of obtuse array indexes
#
#           Board Layout
#    -----------------------------
#    Indexes      |   Positions
#    0   1   2    |   t1  t2  t3
#    3   4   5    |   m1  m2  m3
#    6   7   8    |   b1  b2  b3
#    -----------------------------
#    Rows            Columns
#    - top = t       - left = 1
#    - middle = m    - center = 2
#    - bottom = b    - right = 3
#    -----------------------------
class Position

  def initialize
    @map = {"t1" => 0, "t2" => 1, "t3" => 2, "m1" => 3, "m2" => 4, "m3" => 5, "b1" => 6, "b2" => 7, "b3" => 8}
  end

  def get_index(move)
    @map[move]
  end

  def map_win(win)
    translated = []
    win.each do |move|
      translated.push(@map.key(move))
    end
    translated.join(", ")
  end

end

# Sandbox testing
# position = Position.new
# win = [0, 4, 8]
# p position.map_win(win)  # ["t1", "m2", "b3"]