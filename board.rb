class Board

  # Method to access the variables in the class - attr_ is shorthand syntax for creating getter/setter methods
  # attr_reader :t_board  # attr_reader = read-only, this will pass test 1, but then will never be able to update the value of board
  attr_accessor :t_board  # attr_reader = read-only, this will pass test 1, but then will never be able to update the value of board

  def initialize()
    # use instance variable if not resetting the value anywhere else
    @t_board = ["", "", "", "", "", "", "", "", ""]
  end

  def to_s()
    return "The board is: #{@t_board}."
  end

  def set_position(position, character)
    @t_board[position] = character
  end

  def check_position?(position)
    if @t_board[position] == ""
      true
    else
      false
    end
  end

  def check_full?()
    @t_board.count("") == 0
  end

end