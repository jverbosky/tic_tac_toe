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
before do
  log = File.new("sinatra.log", "a")
  STDOUT.reopen(log)
  STDERR.reopen(log)
end

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

# ## Tested with make_move() and working (5:50 PM)
# # route to display game board, round and previous player move - human & AI players
# # if game is over (win/tie), displays final game results
post '/play' do
  session[:round] = session[:game].round
  puts "round: " + session[:round].inspect
  player_type = session[:game].set_player_type
  puts "player_type: " + player_type.inspect
  x_won = session[:game].x_won
  o_won = session[:game].o_won
  if player_type == "Human"
    move = params[:location]
    puts "human move: " + move.inspect
    session[:game].make_move(move)
    result = session[:game].result
    puts "result: " + result.inspect
    session[:round] -= 1 unless result == ""  # logic to decrement round number if position already taken
  else
    session[:game].make_move("")
    move = session[:game].move
    puts "ai move: " + move.inspect
  end
  session[:rows] = session[:game].output_board
  puts "rows array: " + session[:rows].inspect
  session[:game].game_over?  # check board to see if last move won or tied
  game_over = session[:game].game_over  # update game_over for next conditional block
  if game_over == true
    result = session[:game].result
    win = session[:game].win
    if x_won == false && o_won == false
      erb :game_over, locals: {rows: session[:rows], round: session[:round], result: result, player_type: player_type}
    else
      erb :game_over, locals: {rows: session[:rows], round: session[:round], result: result, win: win}
    end
  elsif player_type == "Human"
    puts "play_human erb"
    erb :play_human, locals: {rows: session[:rows], round: session[:round], move: move, result: result}
  else
    puts "play_ai erb"
    erb :play_ai, locals: {rows: session[:rows], round: session[:round], p1_type: session[:p1_type], p2_type: session[:p2_type], move: move}
  end
end

## Tested with make_move() and working (4:23 PM)
# route to display game board, round and previous player move - ai players
# if game is over (win/tie), displays final game results
# post '/play' do
#   session[:round] = session[:game].round
#   player_type = session[:game].set_player_type
#   x_won = session[:game].x_won
#   o_won = session[:game].o_won
#   session[:game].make_move("")
#   move = session[:game].move
#   session[:rows] = session[:game].output_board
#   session[:game].game_over?  # check board to see if last move won or tied
#   game_over = session[:game].game_over
#   if game_over == true
#     result = session[:game].result
#     win = session[:game].win
#     if x_won == false && o_won == false
#       erb :game_over, locals: {rows: session[:rows], round: session[:round], result: result}
#     else
#       erb :game_over, locals: {rows: session[:rows], round: session[:round], result: result, win: win}
#     end
#   else
#     erb :play_ai, locals: {rows: session[:rows], round: session[:round], p1_type: session[:p1_type], p2_type: session[:p2_type], move: move}
#   end
# end

## Backup of /play route with human player logic
# route to display game board, round and previous player move - human players
# if game is over (win/tie), displays final game results
# post '/play' do
#   session[:round] = session[:game].round
#   player_type = session[:game].set_player_type
#   x_won = session[:game].x_won
#   o_won = session[:game].o_won
#   move = params[:location]
#   session[:game].make_move(move)
#   result = session[:game].result
#   session[:round] -= 1 unless result == ""  # logic to decrement round number if position already taken
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