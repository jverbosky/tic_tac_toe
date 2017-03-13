####################################
############ Tic Tac Toe ###########
####################################

require 'sinatra'
# require 'sinatra/reloader' if development?  # automatically reload app.rb on save via sinatra-contrib gem
require_relative 'game.rb'

enable :sessions
# enable :logging, :dump_errors, :raise_errors

# Variables for scores (global to persist through new game instances)
$x_score = 0  # global for X score to persist through multiple games
$o_score = 0  # global for O score to persist through multiple games

# route to tracing variables through route iterations
# before do
#   log = File.new("sinatra.log", "a")
#   STDOUT.reopen(log)
#   STDERR.reopen(log)
# end

# route to load the player selection screen
get '/' do
  session[:game] = Game.new
  session[:game].new_game
  session[:intro] = [["", "", "X"], ["O", "O", "X"], ["X", "", ""]]
  erb :start, locals: {rows: session[:intro]}
end

# route to display the selected players and begin the game
post '/players' do
  player_type = params[:player_type]
  session[:game].select_players(player_type)
  session[:p1_type] = session[:game].p1_type
  session[:p2_type] = session[:game].p2_type
  erb :player_type, locals: {rows: session[:intro], p1_type: session[:p1_type], p2_type: session[:p2_type]}
end

# route to display game board, round and previous player move - human players
# if game is over (win/tie), displays final game results
# post '/play' do
#   session[:round] = session[:game].round
#   x_won = session[:game].x_won
#   o_won = session[:game].o_won
#   move = params[:location]
#   session[:game].human_move(move)
#   result = session[:game].result
#   session[:rows] = session[:game].output_board
#   session[:game].game_over?  # check board to see if last move won or tied
#   game_over = session[:game].game_over  # update game_over for next conditional block
#   if game_over == true
#     result = session[:game].result
#     win = session[:game].win
#     if x_won == false && o_won == false
#       erb :game_over, locals: {rows: session[:rows], round: session[:round], result: result}
#     else
#       erb :game_over, locals: {rows: session[:rows], round: session[:round], result: result, win: win}
#     end
#   else
#     erb :play_human, locals: {rows: session[:rows], round: session[:round], move: move, result: result}
#   end
# end

# route to display game board, round and previous player move - ai players
# if game is over (win/tie), displays final game results
post '/play' do
  session[:round] = session[:game].round
  # game_over = session[:game].game_over
  x_won = session[:game].x_won
  o_won = session[:game].o_won
  session[:game].play_game #unless session[:round] == 10 || game_over == true
  move = session[:game].move
  session[:rows] = session[:game].output_board
  session[:game].game_over?  # check board to see if last move won or tied
  game_over = session[:game].game_over
  if game_over == true
    result = session[:game].result
    win = session[:game].win
    # win = session[:game].position.map_win(session[:game].board.win)
    if x_won == false && o_won == false
      erb :game_over, locals: {rows: session[:rows], round: session[:round], result: result}
    else
      erb :game_over, locals: {rows: session[:rows], round: session[:round], result: result, win: win}
    end
  else
    erb :play_ai, locals: {rows: session[:rows], round: session[:round], p1_type: session[:p1_type], p2_type: session[:p2_type], move: move}
  end
  #   if x_won == true
  #     $x_score += 1
  #     result = "#{session[:p1_type]} X won the game!<br>The winning positions were: #{win}"
  #     erb :game_over, locals: {rows: session[:rows], round: session[:round], result: result, win: win}
  #   elsif o_won == true
  #     $o_score += 1
  #     result = "#{session[:p2_type]} O won the game!<br>The winning positions were: #{win}"
  #     erb :game_over, locals: {rows: session[:rows], round: session[:round], result: result, win: win}
  #   elsif x_won == false && o_won == false
  #     result = "It was a tie!"
  #     erb :game_over, locals: {rows: session[:rows], round: session[:round], result: result}
  #   end
  # else
  #   erb :play_ai, locals: {rows: session[:rows], round: session[:round], p1_type: session[:p1_type], p2_type: session[:p2_type], move: move}
  # end
end

## Backup - AI logic only, working just fine ##
# # route to display game board, round and previous player move
# # if game is over (win/tie), displays final game results
# post '/play' do
#   session[:round] = session[:game].round
#   game_over = session[:game].game_over
#   x_won = session[:game].x_won
#   o_won = session[:game].o_won
#   session[:game].play_game unless session[:round] == 10 || game_over == true
#   move = session[:game].move
#   session[:rows] = session[:game].output_board
#   if game_over == true
#     win = session[:game].position.map_win(session[:game].board.win)
#     if x_won == true
#       $x_score += 1
#       result = "#{session[:p1_type]} X won the game!<br>The winning positions were: #{win}"
#       erb :game_over, locals: {rows: session[:rows], round: session[:round], result: result, win: win}
#     elsif o_won == true
#       $o_score += 1
#       result = "#{session[:p2_type]} O won the game!<br>The winning positions were: #{win}"
#       erb :game_over, locals: {rows: session[:rows], round: session[:round], result: result, win: win}
#     elsif x_won == false && o_won == false
#       result = "It was a tie!"
#       erb :game_over, locals: {rows: session[:rows], round: session[:round], result: result}
#     end
#   else
#     erb :play_ai, locals: {rows: session[:rows], round: session[:round], p1_type: session[:p1_type], p2_type: session[:p2_type], move: move}
#   end
# end


## Backup of /play route with human player logic
# route to display game board, round and previous player move
# if game is over (win/tie), displays final game results
# post '/play' do
#   session[:round] = session[:game].round
#   puts "round: " + session[:round].inspect
#   x_won = session[:game].x_won
#   puts "x_won: " + x_won.inspect
#   o_won = session[:game].o_won
#   puts "x\o_won: " + o_won.inspect
#   move = params[:location]
#   puts "move: " + move.inspect
#   session[:game].human_move(move)
#   session[:rows] = session[:game].output_board
#   puts "board: " + session[:rows].inspect
#   session[:game].game_over?  # check board to see if last move won or tied
#   game_over = session[:game].game_over  # update game_over for next conditional block
#   puts "game_over: " + game_over.inspect
#   if game_over == true
#     result = session[:game].result
#     puts "result: " + result.inspect
#     win = session[:game].win
#     puts "win: " + win.inspect
#     if x_won == false && o_won == false
#       erb :game_over, locals: {rows: session[:rows], round: session[:round], result: result}
#     else
#       erb :game_over, locals: {rows: session[:rows], round: session[:round], result: result, win: win}
#     end
#   else
#     erb :play_human, locals: {rows: session[:rows], round: session[:round], p1_type: session[:p1_type], p2_type: session[:p2_type], move: move}
#   end
# end