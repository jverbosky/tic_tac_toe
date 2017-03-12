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
  session[:x_score] = $x_score
  session[:o_score] = $o_score
  session[:intro_rows] = [["", "", "X"], ["O", "O", "X"], ["X", "", ""]]
  erb :start, locals: {rows: session[:intro_rows], x_score: session[:x_score], o_score: session[:o_score]}
end

post '/players' do
  player_type = params[:player_type]
  session[:game].select_players(player_type)
  session[:p1_type] = session[:game].p1_type
  session[:p2_type] = session[:game].p2_type
  # "Player type: #{player_type}, p1: #{session[:p1_type]}, p2: #{session[:p2_type]}"
  erb :player_type, locals: {rows: session[:intro_rows], p1_type: session[:p1_type], p2_type: session[:p2_type], x_score: session[:x_score], o_score: session[:o_score]}
end

# post '/play' do
#   session[:rows] = session[:game].output_board
#   if session[:p1_type] == "Human"
#     erb :play_human, locals: {rows: session[:rows], p1_type: session[:p1_type], p2_type: session[:p2_type]}
#   else
#     erb :play_ai, locals: {rows: session[:rows], p1_type: session[:p1_type], p2_type: session[:p2_type]}
#   end
# end

post '/play' do
  round = session[:game].round
  game_over = session[:game].game_over
  x_won = session[:game].x_won
  x_score = session[:game].x_score
  o_won = session[:game].o_won
  o_score = session[:game].o_score
  # if round == 1
  #   session[:rows] = session[:game].output_board
  # else
    # if round % 2 == 1
    #   if session[:p1_type] == "Human"
    #     session[:game].move = params[:location]
    #     session[:game].play_game
    #   else
    #     session[:game].play_game
    #   end
    # else
    #   if session[:p2_type] == "Human"
    #     session[:game].move = params[:location]
    #     session[:game].play_game
    #   else
        # session[:game].play_game
    #   end
    # end
    session[:rows] = session[:game].output_board
    session[:game].play_game
  # end
  if game_over == true
    if x_won == true
      result = "X won the game!"
      erb :game_over, locals: {rows: session[:rows], result: result, x_score: session[:x_score], o_score: session[:o_score]}
    elsif o_won == true
      result = "O won the game!"
      erb :game_over, locals: {rows: session[:rows], result: result, x_score: session[:x_score], o_score: session[:o_score]}
    else
      result = "It was a tie!"
      erb :game_over, locals: {rows: session[:rows], result: result, x_score: session[:x_score], o_score: session[:o_score]}
    end
  elsif round % 2 == 1
    if session[:p1_type] == "Human"
      erb :play_human, locals: {rows: session[:rows], p1_type: session[:p1_type], p2_type: session[:p2_type], round: round, x_score: session[:x_score], o_score: session[:o_score]}
    else
      erb :play_ai, locals: {rows: session[:rows], p1_type: session[:p1_type], p2_type: session[:p2_type], round: round, x_score: session[:x_score], o_score: session[:o_score]}
    end
  else
    if session[:p2_type] == "Human"
      erb :play_human, locals: {rows: session[:rows], p1_type: session[:p1_type], p2_type: session[:p2_type], round: round, x_score: session[:x_score], o_score: session[:o_score]}
    else
      erb :play_ai, locals: {rows: session[:rows], p1_type: session[:p1_type], p2_type: session[:p2_type], round: round, x_score: session[:x_score], o_score: session[:o_score]}
    end
  end
end

# post '/play_more' do
#   session[:rows] = session[:game].output_board
#   # need to access logic for rounds, p1/p2 selection based on rounds
#   round = session[:game].round
#   unless round % 2 == 0
#     if session[:p1_type] == "Human"
#       erb :play_human, locals: {rows: session[:rows], p1_type: session[:p1_type], p2_type: session[:p2_type]}
#     else
#       erb :play_ai, locals: {rows: session[:rows], p1_type: session[:p1_type], p2_type: session[:p2_type]}
#     end
#   else
#     if session[:p2_type] == "Human"
#       erb :play_human, locals: {rows: session[:rows], p1_type: session[:p1_type], p2_type: session[:p2_type]}
#     else
#       erb :play_ai, locals: {rows: session[:rows], p1_type: session[:p1_type], p2_type: session[:p2_type]}
#     end
#   end
# end

# post '/move_human' do
#   session[:game].move = params[:location]
#   session[:game].play_game
#   session[:rows] = session[:game].output_board
#   # erb :play_human, locals: {rows: session[:rows], p1_type: session[:p1_type], p2_type: session[:p2_type]}
#   erb :play, locals: {rows: session[:rows], p1_type: session[:p1_type], p2_type: session[:p2_type]}
# end

# post '/move_ai' do
#   session[:game].play_game
#   session[:rows] = session[:game].output_board
#   # erb :play_ai, locals: {rows: session[:rows], p1_type: session[:p1_type], p2_type: session[:p2_type]}
#   erb :play, locals: {rows: session[:rows], p1_type: session[:p1_type], p2_type: session[:p2_type]}
# end
