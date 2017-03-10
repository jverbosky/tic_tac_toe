require_relative "board.rb"
require_relative "position.rb"

# class to outputting final game board and results to terminal
class Console

  # Method to clear the screen regardless of OS
  def clear_screen
    RUBY_PLATFORM =~ /cygwin|mswin|mingw|bccwin|wince|emx/ ? system("cls") : system("clear")
  end

  # def output_board(board)
  #   clear_screen
  #   puts "-" * 17
  #   puts "   Tic Tac Toe"
  #   puts "-" * 17
  #   spaced = []
  #   board.each { |mark| mark == "" ? spaced.push(" ") : spaced.push(mark) }
  #   rows = spaced.each_slice(3).to_a
  #   rows.each { |row|  print "      " + row.join(" ") + "\n" }
  # end

  def output_board(board)
    clear_screen
    puts "-" * 31
    puts " " * 10 + "Tic Tac Toe"
    puts "-" * 31
    puts "\n"
    spaced = []
    board.each { |mark| mark == "" ? spaced.push(" ") : spaced.push(mark) }
    rows = spaced.each_slice(3).to_a
    rows.each_with_index do |row, index|
      if index < 2
        print " " * 11 + row.join(" | ") + "\n"
        puts " " * 11 + "-" * 9
      else
        print " " * 11 + row.join(" | ") + "\n"
      end
    end
    puts "\n"
  end


# X | O | X
# ----------
# O | X | O
# ----------
# X | O | X






  def output_results(x_won, o_won, win)
    puts "-" * 31
    if x_won == true
      puts " " * 7 + "Player 1 (X) won!"
      # puts "-" * 31
      puts "\n"
      puts " " * 3 + "Winning moves: #{win}"
      puts "-" * 31
    elsif o_won == true
      puts " " * 7 + "Player 2 (O) won!"
      # puts "-" * 31
      puts "\n"
      puts " " * 3 + "Winning moves: #{win}"
      puts "-" * 31
    else
      puts " It was a tie!"
    end
  end

end

  # def output_win(board)
  #   puts board.win
  # end

# Sandbox testing
# board = Board.new
# console = Console.new
# position = Position.new
# # board.game_board = ["", "", "X", "", "X", "O", "X", "", "O"]  # X win
# # board.game_board = ["X", "", "", "O", "O", "O", "", "X", "X"]  # O win
# # board.game_board = ["O", "X", "O", "", "X", "", "X", "X", "O"]  # X win
# board.game_board = ["O", "X", "X", "", "O", "", "X", "", "O"]  # O win
# x_won = board.x_won?(board.get_x)
# o_won = board.o_won?(board.get_o)
# win = board.get_win
# translated = position.map_win(win)
# console.output_results(x_won, o_won, translated)