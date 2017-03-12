####################################
############ Tic Tac Toe ###########
####################################

require 'sinatra'
require 'sinatra/reloader' if development?  # automatically reload app.rb on save via sinatra-contrib gem
require_relative 'game.rb'

get '/' do  # route to load the initial Tic Tac Toe page
  # new_game
  # output_board
  game = Game.new
  game.new_game
  rows = game.output_board
  # rows = [["", "", "X"], ["O", "O", "X"], ["X", "", ""]]
  erb :start, locals: {rows: rows}
end

post '/play' do
  player_type = params[:player_type]
  # select_players(player_type)
  "Player type: #{player_type}"  # Player type: {"p1_type"=>"perfect", "p2_type"=>"random"}
end