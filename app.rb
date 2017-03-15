####################################
############ Tic Tac Toe ###########
####################################

require 'sinatra'
require_relative 'game.rb'

class TicTacToeApp < Sinatra::Base

  # allow variable value to persist through routes (don't use when need to update value)
  enable :sessions

  # variables to hold player scores (global to persist through new game instances)
  $x_score = 0  # global for X score to persist through multiple games
  $o_score = 0  # global for O score to persist through multiple games

  # route to load the player selection screen
  get '/' do
    session[:game] = Game.new  # create a new game instance
    # session[:game].new_game  # start a new game
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

  # route to display game board, round and AI player move details
  # if game is over (win/tie), displays final game results
  get '/play_ai' do
    round = session[:game].round
    result = session[:game].result
    player_type = session[:game].set_player_type
    session[:game].make_move("")
    move = session[:game].move
    rows = session[:game].output_board  # grab the current board to display via layout.erb
    if session[:game].game_over?  # check board to see if last move won or tied
      session[:game].display_results
      result = session[:game].result  # update result based on game over condition
      erb :game_over, locals: {rows: rows, round: round, result: result}
    else
      erb :play_ai, locals: {rows: rows, round: round, move: move, p1_type: session[:p1_type], p2_type: session[:p2_type]}
    end
  end

  # route to allow input of human player move
  get '/play_human' do
    result = session[:game].result
    round = session[:game].round
    rows = session[:game].output_board  # grab the current board to display via layout.erb
    erb :play_human, locals: {rows: rows, round: round, result: result}
  end

  # route to display game board, round and human player move details
  # if game is over (win/tie), displays final game results
  post '/result_human' do
    round = session[:game].round
    player_type = session[:game].set_player_type
    move = params[:location]
    session[:game].make_move(move)  # pass selected move to make_move() in game.rb
    result = session[:game].result  # update to see if any feedback about position being taken
    rows = session[:game].output_board  # grab the current board to display via layout.erb
    if session[:game].game_over?  # check board to see if last move won or tied
      session[:game].display_results
      result = session[:game].result  # update result based on game over condition
      erb :game_over, locals: {rows: rows, round: round, result: result}
    elsif result != ""
      erb :play_human, locals: {rows: rows, round: round, result: result}
    else
      erb :result_human, locals: {rows: rows, round: round, result: result, move: move, p1_type: session[:p1_type], p2_type: session[:p2_type]}
    end
  end

end