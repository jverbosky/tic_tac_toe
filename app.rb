####################################
############ Tic Tac Toe ###########
####################################

require 'sinatra'
# require 'sinatra/reloader' if development?  # automatically reload app.rb on save via sinatra-contrib gem
require_relative 'game.rb'

enable :sessions

  # route to load the initial Tic Tac Toe page
get '/' do
  session[:game] = Game.new
  session[:game].new_game
  session[:intro_rows] = [["", "", "X"], ["O", "O", "X"], ["X", "", ""]]
  erb :start, locals: {rows: session[:intro_rows]}
end

post '/players' do
  player_type = params[:player_type]
  session[:game].select_players(player_type)
  session[:p1_type] = session[:game].p1_type
  session[:p2_type] = session[:game].p2_type
  # "Player type: #{player_type}, p1: #{session[:p1_type]}, p2: #{session[:p2_type]}"
  erb :player_type, locals: {rows: session[:intro_rows], p1_type: session[:p1_type], p2_type: session[:p2_type]}
end

post '/player_1' do
  session[:rows] = session[:game].output_board
  if session[:p1_type] == "human"
    erb :play_human, locals: {rows: session[:rows]}
  else
    erb :play_ai, locals: {rows: session[:rows]}
  end
end

post '/player_2' do
  session[:rows] = session[:game].output_board
  if session[:p1_type] == "human"
    erb :play_human, locals: {rows: session[:rows]}
  else
    erb :play_ai, locals: {rows: session[:rows]}
  end
end

post '/move_human' do
  move = params[:location]
  session[:game].human_move(move)
  session[:rows] = session[:game].output_board
  erb :play_human, locals: {rows: session[:rows]}
end

post '/move_ai' do
  session[:rows] = session[:game].output_board
end
