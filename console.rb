require_relative "board.rb"
require_relative "position.rb"

# class to outputting final game board and results to terminal
class Console

  attr_reader :p1_type, :p2_type

  def initialize
    @p1_type = ""
    @p2_type = ""
  end

  def get_p1_type
    @p1_type
  end

  def get_p2_type
    @p2_type
  end

  # Method to clear the screen regardless of OS
  def clear_screen
    RUBY_PLATFORM =~ /cygwin|mswin|mingw|bccwin|wince|emx/ ? system("cls") : system("clear")
  end

  def border(n)
    puts "-" * n
  end

  def tab(n)
    print " " * n
  end

  def output_board(board)
    clear_screen
    border(31)
    tab(10)
    puts "Tic Tac Toe"
    border(31)
    puts "\n"
    spaced = []
    board.each { |mark| mark == "" ? spaced.push(" ") : spaced.push(mark) }
    rows = spaced.each_slice(3).to_a
    rows.each_with_index do |row, index|
      if index < 2
        tab(11)
        print row.join(" | ") + "\n"
        tab(11)
        border(9)
      else
        tab(11)
        print row.join(" | ") + "\n"
      end
    end
    puts "\n"
  end

  def select_players
    clear_screen
    border(31)
    tab(10)
    puts "Tic Tac Toe"
    border(31)
    puts "\n"
    tab(11)
    puts "  |   | X"
    tab(11)
    puts "-" * 9
    tab(11)
    puts "O | O | X"
    tab(11)
    puts "-" * 9
    tab(11)
    puts "X |   |"
    puts "\n"
    border(31)
    tab(8)
    puts "Player Selection"
    border(31)
    tab(11)
    puts "1 = human"
    tab(11)
    puts "2 = perfect"
    tab(11)
    puts "3 = random"
    tab(11)
    puts "4 = sequential"
    border(31)
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
    tab(12)
    puts "Great!!!"
    tab(5)
    puts "X is a #{@p1_type} player."
    border(31)
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
    tab(10)
    puts "Excellent!!!"
    tab(5)
    puts "O is a #{@p2_type} player."
    border(31)
    tab(2)
    puts "Please press Enter to begin!"
    border(31)
    gets.chomp
  end

  def opening
    border(31)
    tab(5)
    puts "Let the game begin!!!"
    border(31)
    tab(4)
    puts "Press Enter to continue."
    border(31)
    input = gets.chomp
  end

  def move_status
  end

  def output_results(x_won, o_won, win, round, mark, move)
    border(31)
    tab(4)
    puts "Round #{round}: #{mark} selected #{move}"
    border(31)
    if x_won == true
      tab(7)
      puts "Player 1 (X) won!"
      puts "\n"
      tab(3)
      puts "Winning moves: #{win}"
      border(31)
    elsif o_won == true
      tab(7)
      puts "Player 2 (O) won!"
      puts "\n"
      tab(3)
      puts "Winning moves: #{win}"
      border(31)
    else
      puts " It was a tie!"
    end
  end

  # def output_results(x_won, o_won, win)
  #   puts "-" * 31
  #   if x_won == true
  #     tab(7)
  #     puts "Player 1 (X) won!"
  #     puts "\n"
  #     tab(3)
  #     puts "Winning moves: #{win}"
  #     border(31)
  #   elsif o_won == true
  #     tab(7)
  #     puts "Player 2 (O) won!"
  #     puts "\n"
  #     tab(3)
  #     puts "Winning moves: #{win}"
  #     border(31)
  #   else
  #     puts " It was a tie!"
  #   end
  # end

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