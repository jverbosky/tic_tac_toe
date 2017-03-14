####################################
############ Tic Tac Toe ###########
####################################

require 'sinatra'
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

# ----Working with everything except human player selecting taken position----------

# # route to display the selected players and begin the game
# post '/players' do
#   player_type = params[:player_type]
#   session[:game].select_players(player_type)
#   session[:p1_type] = session[:game].p1_type
#   session[:p2_type] = session[:game].p2_type
#   erb :player_type, locals: {rows: session[:intro], p1_type: session[:p1_type], p2_type: session[:p2_type]}
# end

# # route to display game board, round and previous player move - ai players
# # if game is over (win/tie), displays final game results
# get '/play_ai' do
#   round = session[:game].round
#   player_type = session[:game].set_player_type
#   x_won = session[:game].x_won
#   o_won = session[:game].o_won
#   session[:game].make_move("")
#   move = session[:game].move
#   rows = session[:game].output_board
#   session[:game].game_over?  # check board to see if last move won or tied
#   game_over = session[:game].game_over
#   if game_over == true
#     result = session[:game].result
#     win = session[:game].win
#     if x_won == false && o_won == false
#       erb :game_over, locals: {rows: rows, round: round, result: result}
#     else
#       erb :game_over, locals: {rows: rows, round: round, result: result, win: win}
#     end
#   else
#     erb :play_ai, locals: {rows: rows, round: round, p1_type: session[:p1_type], p2_type: session[:p2_type], move: move}
#   end
# end

# # route to allow input of human player move
# get '/play_human' do
#   round = session[:game].round
#   player_type = session[:game].set_player_type
#   rows = session[:game].output_board
#   # erb :play_human, locals: {rows: rows, round: round, move: session[:move], result: result}
#   erb :play_human, locals: {rows: rows, round: round}
# end

# # route to collect and display results of human player move
# # if game is over (win/tie), displays final game results
# post '/result_human' do
#   result = session[:game].result
#   session[:game].round -= 1 unless result == "" # decrement round number if position already taken
#   round = session[:game].round
#   player_type = session[:game].set_player_type
#   x_won = session[:game].x_won
#   o_won = session[:game].o_won
#   move = params[:location]
#   session[:game].make_move(move)
#   # round -= 1 unless result == ""  # logic to decrement round number if position already taken
#   rows = session[:game].output_board
#   session[:game].game_over?  # check board to see if last move won or tied
#   game_over = session[:game].game_over  # update game_over for next conditional block
#   if game_over == true
#     result = session[:game].result
#     win = session[:game].win
#     if x_won == false && o_won == false
#       erb :game_over, locals: {rows: rows, round: round, result: result, player_type: player_type}
#     else
#       erb :game_over, locals: {rows: rows, round: round, result: result, win: win}
#     end
#   else  # need to add an elsif to go back to /play_human if result != ""
#     erb :result_human, locals: {rows: rows, round: round, move: move, result: result, p1_type: session[:p1_type], p2_type: session[:p2_type]}
#   end
# end

# ----In progress - advise & reprompt when human player selects taken position----------

# route to display the selected players and begin the game
post '/players' do
  player_type = params[:player_type]
  session[:game].select_players(player_type)
  session[:p1_type] = session[:game].p1_type
  session[:p2_type] = session[:game].p2_type
  erb :player_type, locals: {rows: session[:intro], p1_type: session[:p1_type], p2_type: session[:p2_type]}
end

# route to display game board, round and AI player move details
# if game is over (win/tie), displays final game results
get '/play_ai' do
  round = session[:game].round
  result = session[:game].result
  player_type = session[:game].set_player_type
  x_won = session[:game].x_won
  o_won = session[:game].o_won
  session[:game].make_move("")
  move = session[:game].move
  rows = session[:game].output_board
  session[:game].game_over?  # check board to see if last move won or tied
  game_over = session[:game].game_over  # update game_over for next conditional block
  if game_over == true
    result = session[:game].result  # update result based on game over condition
    win = session[:game].win
    if x_won == false && o_won == false
      erb :game_over, locals: {rows: rows, round: round, result: result}
    else
      erb :game_over, locals: {rows: rows, round: round, result: result, win: win}
    end
  else
    erb :play_ai, locals: {rows: rows, round: round, move: move, p1_type: session[:p1_type], p2_type: session[:p2_type]}
  end
end

# route to allow input of human player move
get '/play_human' do
  result = session[:game].result
  round = session[:game].round
  rows = session[:game].output_board
  erb :play_human, locals: {rows: rows, round: round, result: result}
end

# route to display game board, round and human player move details
# if game is over (win/tie), displays final game results
post '/result_human' do
  round = session[:game].round
  player_type = session[:game].set_player_type
  x_won = session[:game].x_won
  o_won = session[:game].o_won
  move = params[:location]
  session[:game].make_move(move)
  result = session[:game].result
  rows = session[:game].output_board
  session[:game].game_over?  # check board to see if last move won or tied
  game_over = session[:game].game_over  # update game_over for next conditional block
  if game_over == true
    result = session[:game].result  # update result based on game over condition
    win = session[:game].win
    if x_won == false && o_won == false
      erb :game_over, locals: {rows: rows, round: round, result: result, player_type: player_type}
    else
      erb :game_over, locals: {rows: rows, round: round, result: result, win: win}
    end
  elsif result != ""
    erb :play_human, locals: {rows: rows, round: round, result: result}
  else
    erb :result_human, locals: {rows: rows, round: round, result: result, move: move, p1_type: session[:p1_type], p2_type: session[:p2_type]}
  end
end

#------------------------------------------------------------------------

## Tested with make_move() and working (4:23 PM)
# route to display game board, round and previous player move - ai players
# if game is over (win/tie), displays final game results
# post '/play' do
#   round = session[:game].round
#   player_type = session[:game].set_player_type
#   x_won = session[:game].x_won
#   o_won = session[:game].o_won
#   session[:game].make_move("")
#   move = session[:game].move
#   rows = session[:game].output_board
#   session[:game].game_over?  # check board to see if last move won or tied
#   game_over = session[:game].game_over
#   if game_over == true
#     result = session[:game].result
#     win = session[:game].win
#     if x_won == false && o_won == false
#       erb :game_over, locals: {rows: rows, round: round, result: result}
#     else
#       erb :game_over, locals: {rows: rows, round: round, result: result, win: win}
#     end
#   else
#     erb :play_ai, locals: {rows: rows, round: round, p1_type: session[:p1_type], p2_type: session[:p2_type], move: move}
#   end
# end

## Backup of /play route with human player logic
# route to display game board, round and previous player move - human players
# if game is over (win/tie), displays final game results
# post '/play' do
#   round = session[:game].round
#   player_type = session[:game].set_player_type
#   x_won = session[:game].x_won
#   o_won = session[:game].o_won
#   move = params[:location]
#   session[:game].make_move(move)
#   result = session[:game].result
#   round -= 1 unless result == ""  # logic to decrement round number if position already taken
#   rows = session[:game].output_board
#   session[:game].game_over?  # check board to see if last move won or tied
#   game_over = session[:game].game_over  # update game_over for next conditional block
#   if game_over == true
#     result = session[:game].result
#     win = session[:game].win
#     if x_won == false && o_won == false
#       erb :game_over, locals: {rows: rows, round: round, result: result, player_type: player_type}
#     else
#       erb :game_over, locals: {rows: rows, round: round, result: result, win: win}
#     end
#   else
#     erb :play_human, locals: {rows: rows, round: round, move: move, result: result}
#   end
# end