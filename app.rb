####################################
############ Tic Tac Toe ###########
####################################

require 'sinatra'
# require 'sinatra/reloader' if development?  # automatically reload app.rb on save via sinatra-contrib gem
require_relative 'game.rb'

enable :sessions

get '/' do  # route to load the initial Tic Tac Toe page
  # new_game
  # output_board
  session[:game] = Game.new
  session[:game].new_game
  session[:rows] = session[:game].output_board
  # "Rows: #{rows}"
  # rows = [["", "", "X"], ["O", "O", "X"], ["X", "", ""]]
  erb :start, locals: {rows: session[:rows]}
end

post '/players' do
  session[:rows] = session[:game].output_board
  player_type = params[:player_type]
  session[:game].select_players(player_type)
  session[:p1_type] = session[:game].p1_type
  session[:p2_type] = session[:game].p2_type
  erb :player_type, locals: {rows: session[:rows], p1_type: session[:p1_type], p2_type: session[:p2_type]}
end

post '/play_game' do
  session[:rows] = session[:game].output_board
end


  # "Player type: #{player_type}"  # Player type: {"p1_type"=>"perfect", "p2_type"=>"random"}
  # if game.p1_type == "human"
  #   erb :play_human
  # else
  #   erb :play_ai
  # end

# post '/move_human' do
#   location = params[:location]
#   play_game(location)
#   erb: 
# end

# post '/move_ai' do
#   # location = 
# end
