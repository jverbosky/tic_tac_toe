# class to handle game board
class Board

  # Method to access the variables in the class - attr_ is shorthand syntax for creating getter/setter methods
  # attr_reader = read-only, attr_writer = write-only, attr_accessor = read/write
  attr_accessor :game_board # needs to be read/write in order to change the value of board in tests

  def initialize
    @game_board = ["", "", "", "", "", "", "", "", ""]  # new empty game board
  end

  # Method to determine if specfied position is open on @game_board
  def position_open?(position)
    @game_board[position] == ""
  end

  # Method to update position on @game_board with specified player mark (X/O)
  def set_position(position, mark)
    @game_board[position] = mark if position_open?(position)
  end

  # Method that returns an array of @game_board positions occupied by X
  def get_x
    @game_board.each_index.select { |position| @game_board[position] == "X" }
  end

  # Method that returns an array of @game_board positions occupied by X
  def get_o
    @game_board.each_index.select { |position| @game_board[position] == "O" }
  end

end