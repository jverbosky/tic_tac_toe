# class to handle win and endgame items
class Win

  attr_reader :wins, :win

  def initialize
    # use instance variable if not resetting the value anywhere else
    # @game_board = ["", "", "", "", "", "", "", "", ""]
    @game_board = []
    @wins = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    @win = []  # populated with winning positions by game_won?
  end

  def update_board(board)
    @game_board = board
  end

  def board_full?
    @game_board.count("") == 0
  end

  def get_win(positions)
    won = false
    @wins.each { |win| (won = true; @win = win) if positions & win == win }
    won
  end

  def x_won?
    x = @game_board.each_index.select { |position| @game_board[position] == "X" }
    get_win(x)
  end

  def o_won?
    o = @game_board.each_index.select { |position| @game_board[position] == "O" }
    get_win(o)
  end

end