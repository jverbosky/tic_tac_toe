require_relative "../board/board.rb"

# class for computer player that plays perfectly to a win or a tie
class PlayerPerfect

  def initialize
    @moves = ["t1", "t2", "t3", "m1", "m2", "m3", "b1", "b2", "b3"]  # "human friendly" board positions
    @sides = [[0, 1, 2], [2, 5, 8], [6, 7, 8], [0, 3, 6]]  # sides (top, right, bottom, left)
    @corners = [0, 2, 6, 8]  # corner positions
    @opcor_1 = [0, 8]  # opposite corners - set 1
    @opcor_2 = [2, 6]  # opposite corners - set 2
    @edges = [1, 3, 5, 7]  # edge positions
    @opedg_1 = [1, 7]  # opposite edges - set 1
    @opedg_2 = [3, 5]  # opposite edges - set 2
    @adjedg = [[5, 7], [3, 7], [1, 5], [1, 3]]  # adjacent edges (order vital for opposite corner comparison)
    @center = [4]  # center position
  end

  # Method to retrieve optimal position and convert it to a "human friendly" board position
  def get_move(wins, x_pos, o_pos, mark)
    # Use current mark (X/O) to determine  current player, then call appropriate method to get position
    mark == "X" ? position = wins_check(wins, x_pos, o_pos) : position = wins_check(wins, o_pos, x_pos)
    # Translate the position's array index to a "human friendly" board position and return it
    move = @moves[position]
  end

  # Method to return position to win, call block_check() if no wins
  def win_check(wins, player, opponent)
    position = []  # placeholder for position that will give 3-in-a-row
    wins.each do |win|  # check each win pattern
      difference = win - player  # difference between current win array and player position array
      # if player 1 move from win, take position unless already opponent mark
      position.push(difference[0]) unless (opponent & difference).size == 1 if difference.size == 1
    end  # .sample in case of multiple wins, otherwise check for blocks
    position.size > 0 ? position.sample : block_check(wins, player, opponent)
  end

  # Method to return position to block, call sel_rand() if no blocks (rounds 8 and 9)
  def block_check(wins, player, opponent)
    position = []  # placeholder for position that will block the opponent
    wins.each do |win|  # check each win pattern
      difference = win - opponent  # difference between current win array and opponent position array
      # if opponent 1 move from win, block position unless already player mark
      position.push(difference[0]) unless (player & difference).size == 1 if difference.size == 1
    end  # .sample in case of multiple blocks, otherwise check for forks
    position.size > 0 ? position.sample : fork_check(wins, player, opponent)
  end

  # Method to return move to block fork, will create fork or fallback on random if none
  def fork_check(wins, player, opponent)
    block_fork = find_fork(wins, opponent, player)
    get_fork = find_fork(wins, player, opponent)
    if get_fork.size > 0  # if possible to create fork, do it
      move = get_fork.sample
    elsif block_fork.size > 0  # otherwise if opponent can create fork, block it
      move = block_fork.sample
    else
      sel_cen(player, opponent)  # otherwise see if center is available
    end
  end

  # Method to select the center position
  def sel_cen(player, opponent)
    taken = player + opponent  # all occupied board positions
    if (taken & @center).size == 0  # if center is open
      position = 4  # then take it
    else
      sel_op_cor(player, opponent)  # otherwise check for opposite corner
    end
  end

  # Method to return the corner opposite the current corner
  def sel_op_cor(player, opponent)
    corner = (opponent & @corners)  # determine the opponent's corner
    if (@opcor_1 - corner).size == 1  # if @opcor_1 and corner differ by 1
      position = (@opcor_1 - corner)[0]  # opposite corner is in @opcor_1
    elsif (@opcor_2 - corner).size == 1  # if @opcor_2 and corner differ by 1
      position = (@opcor_2 - corner)[0]  # opposite corner is in @opcor_2
    else
      sel_avail_cor(player_opponent)  # otherwise check for any open corner
    end
  end

  # Method to return random open corner when player and opponent occupy one pair of opposing corners
  def sel_avail_cor(player, opponent)
    taken = player + opponent  # all occupied board positions
    avail_cor = @corners - (@corners & taken)  # determine which corners are taken
    if avail_cor.size > 0  # if there are any open corners
      position = avail_cor.sample  # take one of them
    else
      position = sel_avail_edg(player, opponent)  # otherwise take an open edge
    end
  end

  # Method to return random open corner when player and opponent occupy one pair of opposing corners
  def sel_avail_edg(player, opponent)
    taken = player + opponent  # all occupied board positions
    avail_edg = @edges - (@edges & taken)  # determine which edges are taken
    position = avail_edg.sample  # take one of them
  end

  # Method to return array of positions that will result in a fork
  def find_fork(wins, forker, forkee)
    position_counts = count_positions(wins, forker, forkee)
    forking_moves = []
    position_counts.each do |position, count|
      forking_moves.push(position) if count > 1
    end
    (forking_moves & forker).empty? ? forking_moves : []
  end

  # Method to return hash of positions and counts to help identify forks
  def count_positions(wins, forker, forkee)
    potential_wins = get_potential_wins(wins, forker, forkee)
    position_counts = {}
    potential_wins.each do |potential_win|
      potential_win.each do |position|
        position_counts[position] = 0 if position_counts[position] == nil
        position_counts[position] += 1
      end
    end
    return position_counts
  end

  # Method to return array of potential wins for forking player
  def get_potential_wins(wins, forker, forkee)
    potential_wins = []
    wins.each do |win|
      potential_wins.push(win) if (forker & win).size > 0 && (forkee & win).size == 0
    end
    return potential_wins
  end

end