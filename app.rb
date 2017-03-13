####################################
############ Tic Tac Toe ###########
####################################

require 'sinatra'
# require 'sinatra/reloader' if development?  # automatically reload app.rb on save via sinatra-contrib gem
require_relative 'game.rb'

enable :sessions

# Variables for scores (global to persist through new game instances)
$x_score = 0  # global for X score to persist through multiple games
$o_score = 0  # global for O score to persist through multiple games

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

# post '/player_1' do
#   session[:rows] = session[:game].output_board
#   # if session[:p1_type] == "human"
#     erb :play_human, locals: {rows: session[:rows]}
#   # else
#   #   erb :play_ai, locals: {rows: session[:rows]}
#   # end
# end

# post '/move_human' do
#   move = params[:location]
#   session[:game].human_move(move)
#   session[:rows] = session[:game].output_board
#   erb :play_human, locals: {rows: session[:rows]}
# end


post '/play' do
  session[:round] = session[:game].round
  unless params[:location] == nil
    move = params[:location]
    session[:game].human_move(move)
  end
  session[:rows] = session[:game].output_board
  erb :play_human, locals: {rows: session[:rows], round: session[:round]}
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

## Backup - AI logic working, leaving non-working human logic in for reference ##
# route to display game board, round and previous player move
# if game is over (win/tie), displays final game results
# post '/play' do
#   session[:round] = session[:game].round
#   game_over = session[:game].game_over
#   x_won = session[:game].x_won
#   o_won = session[:game].o_won
#   # if round == 1
#   #   session[:rows] = session[:game].output_board
#   # else
#     # if round % 2 == 1
#     #   if session[:p1_type] == "Human"
#     #     session[:game].move = params[:location]
#     #     session[:game].play_game
#     #   else
#     #     session[:game].play_game
#     #   end
#     # else
#     #   if session[:p2_type] == "Human"
#     #     session[:game].move = params[:location]
#     #     session[:game].play_game
#     #   else
#         # session[:game].play_game
#     #   end
#     # end
#   # session[:rows] = session[:game].output_board
#   unless session[:round] == 10 || game_over == true
#     session[:game].play_game
#   end
#   move = session[:game].move
#   session[:rows] = session[:game].output_board
#   # end
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
#   elsif session[:round] % 2 == 1
#     if session[:p1_type] == "Human"
#       erb :play_human, locals: {rows: session[:rows], round: session[:round], p1_type: session[:p1_type], p2_type: session[:p2_type], move: move}
#     else
#       erb :play_ai, locals: {rows: session[:rows], round: session[:round], p1_type: session[:p1_type], p2_type: session[:p2_type], move: move}
#     end
#   else
#     if session[:p2_type] == "Human"
#       erb :play_human, locals: {rows: session[:rows], round: session[:round], p1_type: session[:p1_type], p2_type: session[:p2_type], move: move}
#     else
#       erb :play_ai, locals: {rows: session[:rows], round: session[:round], p1_type: session[:p1_type], p2_type: session[:p2_type], move: move}
#     end
#   end
# end