####################################
############ Tic Tac Toe ###########
####################################

require 'sinatra'
require_relative './game/game.rb'
require_relative './game/messaging.rb'

class TicTacToeApp < Sinatra::Base

  enable :sessions  # allow variable value to persist through routes (don't use when need to update value)
  # enable :logging, :dump_errors, :raise_errors

  # reference for tracing variable value:
  # player_type = "Human"
  # puts "player_type: " + player_type.inspect

  # variables to hold player scores (global to persist through new game instances)
  $x_score = 0  # global for X score to persist through multiple games
  $o_score = 0  # global for O score to persist through multiple games

  # # route to trace variables through route iterations
  # before do
  #   log = File.new("sinatra.log", "a")
  #   STDOUT.reopen(log)
  #   STDERR.reopen(log)
  # end

  # route to load the player selection screen
  get '/' do
    session[:game] = Game.new  # create a new game instance
    session[:messaging] = session[:game].messaging
    session[:intro] = [["", "", "X"], ["O", "O", "X"], ["X", "", ""]]  # board for intro screens
    erb :start, locals: {rows: session[:intro]}
  end

  # route to display the selected players and begin the game
  post '/players' do
    player_type = params[:player_type]  # collect player_type hash from form in start.erb
    session[:game].select_players(player_type)  # initialize player objects based on player_type hash
    # p1_type = session[:game].p1_type  # assign p1_type session to @p1_type in game.rb
    # p2_type = session[:game].p2_type  # assign p1_type session to @p2_type in game.rb
    session[:p1_type] = session[:game].p1_type  # assign p1_type session to @p1_type in game.rb
    session[:p2_type] = session[:game].p2_type  # assign p1_type session to @p2_type in game.rb
    # route = session[:game].get_route  # get route that corresponds to p1_type
    route = session[:messaging].get_route(session[:p1_type])  # get route that corresponds to p1_type
    erb :player_type, locals: {route: route, rows: session[:intro], p1_type: session[:p1_type], p2_type: session[:p2_type]}
  end

  # route to display game board, round and AI player move details
  get '/play_ai' do
    round = session[:game].round  # collect current round for messaging
    move = session[:game].make_move("")  # collect AI player move via make_move() > ai_move
    rows = session[:game].output_board  # grab the current board to display via layout.erb
    # feedback = session[:game].feedback  # collect the resulting move messaging
    # prompt = session[:game].prompt  # collect the updated player advance messaging
    feedback = session[:messaging].feedback  # collect the resulting move messaging
    prompt = session[:messaging].prompt  # collect the updated player advance messaging
    if session[:game].game_over?  # if game is over
      # endgame_result = session[:game].display_results  # collect endgame messaging
      winner = session[:game].end_game
      # winner = session[:game].winner
      endgame_result = session[:messaging].display_results(session[:p1_type], session[:p2_type], winner)  # collect endgame messaging
      erb :game_over, locals: {rows: rows, round: round, result: endgame_result}  # display final results
    else  # otherwise display move results
      # route = session[:game].get_route  # get route and update @player_type_ and @mark_ variables
      route = session[:messaging].get_route(session[:game].pt_next)  # get route that corresponds to next player type
      erb :play_ai, locals: {rows: rows, round: round, feedback: feedback, prompt: prompt, route: route}
    end
  end

  # route to allow input of human player move
  get '/play_human' do
    round = session[:game].round  # collect current round for messaging
    rows = session[:game].output_board  # grab the current board to display via layout.erb
    session[:game].set_players  # update player info
    # feedback = session[:game].human_messaging  # update intro human player messaging
    mark = session[:game].m_current
    feedback = session[:messaging].human_messaging(round, mark)  # update intro human player messaging
    erb :play_human, locals: {rows: rows, round: round, feedback: feedback}
  end

  # route to display game board, round and human player move details
  post '/result_human' do
    round = session[:game].round  # collect current round for messaging
    move = params[:location]  # collect the specified move from play_human form
    session[:game].make_move(move)  # evaluate move for route selection
    # feedback = session[:game].feedback  # collect the resulting move messaging
    # prompt = session[:game].prompt  # collect the updated player advance messaging
    feedback = session[:messaging].feedback  # collect the resulting move messaging
    prompt = session[:messaging].prompt  # collect the updated player advance messaging
    rows = session[:game].output_board  # grab the current board to display via layout.erb
    if session[:game].game_over?  # if game is over
      # endgame_result = session[:game].display_results  # collect endgame messaging
      winner = session[:game].end_game
      endgame_result = session[:messaging].display_results(session[:p1_type], session[:p2_type], winner)  # collect endgame messaging
      erb :game_over, locals: {rows: rows, round: round, result: endgame_result}  # display final results
    elsif feedback =~ /^That/  # if feedback ~ taken position, reprompt via play_human
      erb :play_human, locals: {rows: rows, round: round, feedback: feedback}
    else  # otherwise display move results
      # route = session[:game].get_route  # get route and update @player_type_ and @mark_ variables
      route = session[:messaging].get_route(session[:game].pt_next)  # get route that corresponds to next player type
      erb :result_human, locals: {rows: rows, round: round, feedback: feedback, prompt: prompt, route: route}
    end
  end

end