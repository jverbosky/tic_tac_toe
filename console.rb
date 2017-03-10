require_relative "board.rb"
require_relative "position.rb"
require_relative "game.rb"

# class to outputting final game board and results to terminal
class Console

  attr_reader :p1_type, :p2_type

  def initialize
    @p1_type = ""
    @p2_type = ""
  end

  # Method to clear the screen regardless of OS
  def clear_screen
    RUBY_PLATFORM =~ /cygwin|mswin|mingw|bccwin|wince|emx/ ? system("cls") : system("clear")
  end

  def border(n)
    puts "-" * n
  end

  def tab(n, *string)
    string.each_with_index { |e, i| i == 0 ? (puts " " * n + e) : (puts e) }
  end

  def select_players
    opening
    select_x
    select_o
    tab(2, "Please press Enter to begin!", "-" * 31)
    gets.chomp
  end

  def opening
    clear_screen
    border(31)
    tab(10, "Tic Tac Toe", "-" * 31, "\n")
    tab(11, "  |   | X")
    tab(11, "-" * 9)
    tab(11, "O | O | X")
    tab(11, "-" * 9)
    tab(11, "X |   |", "\n", "-" * 31)
    tab(8, "Player Selection", "-" * 31)
    tab(11, "1 = human")
    tab(11, "2 = perfect")
    tab(11, "3 = random")
    tab(11, "4 = sequential", "-" * 31)
  end

  def select_x
    print " Please select the X player: "
    p1 = gets.chomp
    case p1
      when "1" then @p1_type = "human"
      when "2" then @p1_type = "perfect"
      when "3" then @p1_type = "random"
      when "4" then @p1_type = "sequential"
      else @p1_type = "invalid"
    end
    puts "\n"
    tab(12, "Great!!!")
    tab(5, "X is a #{@p1_type} player.", "-" * 31)
  end

  def select_o
    print " Please select the O player: "
    p2 = gets.chomp
    case p2
      when "1" then @p2_type = "human"
      when "2" then @p2_type = "perfect"
      when "3" then @p2_type = "random"
      when "4" then @p2_type = "sequential"
      else @p2_type = "invalid"
    end
    puts "\n"
    tab(10, "Excellent!!!")
    tab(5, "O is a #{@p2_type} player.", "-" * 31)
  end

  def preamble
    border(31)
    tab(5, "Let the game begin!!!", "-" * 31)
    tab(4, "Press Enter to continue.", "-" * 31)
    input = gets.chomp
  end

  def output_board(board)
    clear_screen
    border(31)
    tab(10, "Tic Tac Toe", "-" * 31)
    puts "\n"
    spaced = []
    board.each { |mark| mark == "" ? spaced.push(" ") : spaced.push(mark) }
    rows = spaced.each_slice(3).to_a
    rows.each_with_index do |row, index|
      index < 2 ? (tab(11, row.join(" | ")); tab(11, "-" * 9)) : tab(11, row.join(" | "))
    end
    puts "\n"
  end

  def move_status(round, mark, move, taken)
    if round > 1
      previous = round - 1
      border(31)
      tab(4, "Round #{previous}: #{mark} selected #{move}")
      if taken == true
        border(31)
        tab(3, "That position isn't open!")
        tab(5, "* Please try again *")
      end
      border(31)
      tab(4, "Press Enter to continue.", "-" * 31)
      input = gets.chomp
    end
  end

  def output_results(x_won, o_won, win, round, mark, move)
    border(31)
    tab(4, "Round #{round}: #{mark} selected #{move}", "-" * 31)
    if x_won == true
      tab(7, "Player 1 (X) won!", "\n")
      tab(3, "Winning moves: #{win}", "-" * 31)
    elsif o_won == true
      tab(7, "Player 2 (O) won!", "\n")
      tab(3, "Winning moves: #{win}", "-" * 31)
    else
      tab(9, "It was a tie!", "-" * 31)
    end
  end

end

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