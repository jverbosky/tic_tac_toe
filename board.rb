class Board

  # Method to access the variables in the class - attr_ is shorthand syntax for creating getter/setter methods
  attr_reader :wins  # attr_reader = read-only, this will pass test 1, but then will never be able to update the value of board
  attr_accessor :game_board  # attr_reader = read-only, this will pass test 1, but then will never be able to update the value of board

  def initialize()
    # use instance variable if not resetting the value anywhere else
    @game_board = ["", "", "", "", "", "", "", "", ""]
    @wins = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
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

  def x_won?()
    current_positions = get_x()
    won = false
    @wins.each { |win| won = true if current_positions & win == win }
    return won
  end

  def o_won?()
    current_positions = get_o()
    won = false
    @wins.each { |win| won = true if current_positions & win == win }
    return won
  end

  def get_player()
    x_count = @game_board.count("X")
    o_count = @game_board.count("O")
    x_count > o_count ? "O" : "X"
  end

  def get_move(position)
    mark = get_player()
    set_position(position, mark) if position_open?(position)
  end

end