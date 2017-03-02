class Board

  # Method to access the variables in the class - attr_ is shorthand syntax for creating getter/setter methods
  # attr_reader :game_board  # attr_reader = read-only, this will pass test 1, but then will never be able to update the value of board
  attr_accessor :game_board  # attr_reader = read-only, this will pass test 1, but then will never be able to update the value of board

  def initialize()
    # use instance variable if not resetting the value anywhere else
    @game_board = ["", "", "", "", "", "", "", "", ""]
  end

  def to_s()
    return "The board is: #{@game_board}."
  end

  def position_open?(position)
    @game_board[position] == ""
  end

  def set_position(position, mark)
    @game_board[position] = mark if position_open?(position)
  end

  def board_full?()
    @game_board.count("") == 0
  end

  def get_x()
    @game_board.each_index.select { |position| @game_board[position] == "X" }
  end

  def get_o()
    @game_board.each_index.select { |position| @game_board[position] == "O" }
  end

end