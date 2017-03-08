require_relative "board.rb"

# class to outputting final game board and results to terminal
class Console

  def initialize
    puts "-" * 11
    puts "Tic Tac Toe"
    puts "-" * 11
  end

  def output_board(board)
    board.map! { |mark| mark == "" ? " " : mark }
    rows = board.each_slice(3).to_a
    rows.each { |row|  print "  " + row.join(" ") + "\n" }
  end

  def output_results(x_won, o_won)
    puts "-" * 11
    if x_won == true
      puts "Player 1 (X) won!"
    elsif o_won == true
      puts "Player 2 (O) won!"
    else
      puts "It was a tie!"
    end
    puts "-" * 11
    puts "\n"
  end

end

# Sandbox testing
board = Board.new
console = Console.new
# board.game_board = ["", "", "", "", "X", "", "", "", ""]  # O
# board.game_board = ["", "", "", "", "X", "", "O", "", ""]  # X
# board.game_board = ["O", "X", "", "", "O", "X", "X", "", "O"]  # X
board.game_board = ["O", "X", "X", "", "O", "X", "X", "", "O"]  # O
console.output_board(board.game_board)
console.output_results(x_won, o_won)