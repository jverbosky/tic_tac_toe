require_relative "board.rb"

# class for computer player that plays perfectly to a win or a tie
class PlayerPerfect

  def initialize
    @moves = ["t1", "t2", "t3", "m1", "m2", "m3", "b1", "b2", "b3"]
  end

  # Method to return position to win, false if none
  def move(wins, player, opponent)
    position = []
    wins.each do |win|
      difference = win - player  # difference between current win array and player position array
      if difference.count == 1  # if player 1 move from win, take position unless already opponent mark
        position.push(difference[0]) unless (opponent & difference).count == 1
      end
    end
    if position.count == 0  # if nothing to block or win, randomly collect an open position
      position.push((Array(0..8) - (player + opponent)).sample)
    end
    position.sample  # .sample in case of multiple
  end

  # Method to return position to block, call win() if nothing to block
  def block(wins, player, opponent)
    position = []
    wins.each do |win|
      difference = win - opponent  # difference between current win array and opponent position array
      if difference.count == 1  # if opponent 1 move from win, block position unless already player mark
        position.push(difference[0]) unless (player & difference).count == 1
      end
    end
    position.count > 0 ? position.sample : move(wins, player, opponent)  # .sample in case of multiple
  end

  # Method to handle o logic for opening rounds
  def opening_o(round)
    position = false
    case round
      when 2 then position = 4  # take the center
      when 4 then position = [1, 3, 5, 7].sample  # take an edge
    end
    position
  end

  # Method to handle x logic for opening rounds
  def opening_x(round, player, opponent)
    position = false
    case round
      when 1 then position = [0, 2, 6, 8].sample  # take a corner
      when 3 then  # take the opposite corner
        case player
          when [0] then position = 8
          when [2] then position = 6
          when [6] then position = 2
          when [8] then position = 0
        end
    end
    position
  end

  def get_move(game_board, round, mark, wins, x_pos, o_pos)
    if round <= 4
       mark == "X" ? position = opening_x(round, x_pos, o_pos) : position = opening_o(round)
    else
      mark == "X" ? position = block(wins, x_pos, o_pos) : position = block(wins, o_pos, x_pos)
    end
    move = @moves[position]
  end

end

# Sandbox testing
# board = Board.new
# p1 = PlayerPerfect.new

# # board.game_board = ["X", "", "", "", "O", "", "", "", ""]  # round 3 - b3
# # board.game_board = ["", "", "X", "", "O", "", "", "", ""]  # round 3 - b1
# # board.game_board = ["", "", "", "", "O", "", "X", "", ""]  # round 3 - t3
# # board.game_board = ["", "", "", "", "O", "", "", "", "X"]  # round 3 - t1

# # board.game_board = ["X", "O", "", "", "O", "", "", "", "X"]  # round 5 - X blocks O at b2
# # board.game_board = ["X", "", "", "O", "O", "", "", "", "X"]  # round 5 - X blocks O at m3
# # board.game_board = ["X", "", "", "", "O", "O", "", "", "X"]  # round 5 - X blocks O at m1
# # board.game_board = ["X", "", "", "", "O", "", "", "O", "X"]  # round 5 - X blocks O at t2

# # board.game_board = ["X", "O", "", "", "O", "", "O", "X", "X"]  # round 7 - X blocks O at t3
# # board.game_board = ["X", "", "O", "O", "O", "X", "", "", "X"]  # round 7 - X blocks O at b1
# # board.game_board = ["", "", "X", "O", "O", "X", "X", "", "O"]  # round 7 - X blocks O at t1
# # board.game_board = ["O", "", "X", "X", "O", "O", "X", "", ""]  # round 7 - X blocks O at b3
# # board.game_board = ["O", "", "X", "", "O", "", "X", "O", ""]  # round 7 - X blocks O at t2

# # board.game_board = ["X", "O", "X", "", "O", "", "O", "X", "X"]  # round 9 - X wins at m3
# # board.game_board = ["X", "", "O", "O", "O", "X", "X", "", "X"]  # round 9 - X wins at b2
# # board.game_board = ["X", "", "X", "X", "O", "O", "O", "", "X"]  # round 9 - X wins at t2
# board.game_board = ["X", "X", "O", "", "O", "", "X", "O", "X"]  # round 9 - X wins at m1

# # board.game_board = ["O", "O", "", "X", "O", "X", "X", "", ""]   # X blocks O at t3, b2 or b3
# # board.game_board = ["X", "X", "", "O", "X", "O", "O", "", ""]   # X wins at t3, b2 or b3
# # board.game_board = ["X", "", "", "", "", "O", "O", "X", ""]   # variation 1 - X will take t2, t3, m1, m2 or b3
# # board.game_board = ["O", "X", "", "", "X", "O", "", "O", "X"]   # variation 2 - X will take t3, m1 or b1

# round = board.get_round(board.x_count, board.o_count)
# mark = board.get_mark(board.x_count, board.o_count)
# wins = board.wins
# x_pos = board.get_x
# o_pos = board.get_o
# puts p1.get_move(board.game_board, round, mark, wins, x_pos, o_pos)