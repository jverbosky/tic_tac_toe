# class to handle win and endgame items
class Win

  # @wins and @win need to be available to the Game class
  attr_reader :wins, :win
  # attr_reader :game_board, :wins, :win  # use for unit testing

  def initialize
    @game_board = []  # populated with current game board by game_over? in Game class
    @wins = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    @win = []  # populated with winning positions by game_won?
  end

  # Method get the current game board for endgame evaluations
  def update_board(board)
    @game_board = board
  end

  # Method to determine if the game board is full (endgame condition)
  def board_full?
    @game_board.count("") == 0
  end

  # Method to update @win with the winning positions and return true if player won
  def get_win(positions)
    won = false
    @wins.each { |win| (won = true; @win = win) if positions & win == win }
    won
  end

  # Method to determine if X won (endgame position)
  def x_won?
    x = @game_board.each_index.select { |position| @game_board[position] == "X" }
    get_win(x)
  end

  # Method to determin if O Won (endgame condition)
  def o_won?
    o = @game_board.each_index.select { |position| @game_board[position] == "O" }
    get_win(o)
  end

end