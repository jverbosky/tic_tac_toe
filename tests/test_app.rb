require 'minitest/autorun'  # need for the Minitest::Test class
require 'rack/test'  # need for the Rack::Test::Methods mixin
require_relative '../app.rb'  # path to app file (one subdirectory higher than this file)

class TestApp < Minitest::Test  # TestApp subclass inherits from Minitest::Test class
  include Rack::Test::Methods  # Include the methods in the Rack::Test:Methods module (mixin)
  # Methods include: get, post, last_response, follow_redirect!

  def app
    TicTacToeApp  # most examples use App.new - reason why we don't need .new here?     ?????
  end

  def test_get_entry_page
    get '/'  # verify a (get '/' do) route exists - doesn't need erb statement to pass
    assert(last_response.ok?)  # verify server response == 200 for (get '/') action - doesn't need erb statement to pass
    assert(last_response.body.include?('Please select the player types:'))
    assert(last_response.body.include?('<form method="post" action="players">'))
    assert(last_response.body.include?('<select type="text" name="player_type[p1_type]">'))
    assert(last_response.body.include?('<select type="text" name="player_type[p2_type]">'))
    assert(last_response.body.include?('<option value="Human">Human</option>'))
    assert(last_response.body.include?('<option value="Perfect">Perfect</option>'))
    assert(last_response.body.include?('<option value="Random">Random</option>'))
    assert(last_response.body.include?('<option value="Sequential">Sequential</option>'))
    assert(last_response.body.include?('<option value="Unbeatable">Unbeatable</option>'))
  end

  def test_post_players
    get '/'  # use to instantiate objects and initialize variable sessions
    assert(last_response.ok?)
    post '/players', player_type: {"p1_type"=>"Sequential", "p2_type"=>"Human"}
    # output = last_response.to_a  # use to put last_response object data in an array
    # puts "last response: #{output}"  # use to make last_response data visible for seeing errors
    assert(last_response.ok?)
    assert(last_response.body.include?('Got it!'))
    assert(last_response.body.include?('Sequential'))
    assert(last_response.body.include?('Human'))
    assert(last_response.body.include?('X is <u>Sequential</u> and O is <u>Human</u>.'))
    assert(last_response.body.include?('Press <b>Play</b> to begin the game'))
    assert(last_response.body.include?('<button><a href=/play_ai>Play</a></button>'))
  end

  def test_play_ai_round_1
    get '/'  # use to instantiate objects and initialize variable sessions
    assert(last_response.ok?)
    post '/players', player_type: {"p1_type"=>"Sequential", "p2_type"=>"Human"}
    assert(last_response.ok?)
    get '/play_ai'  # verify a (get '/' do) route exists - doesn't need erb statement to pass
    # output = last_response.to_a  # use to put last_response object data in an array
    # puts "last response: #{output}"  # use to make last_response data visible for seeing errors
    assert(last_response.ok?)  # verify server response == 200 for (get '/') action - doesn't need erb statement to pass
    assert(last_response.body.include?('Round 1'))
    assert(last_response.body.include?('Sequential X took t1 in round 1.'))
    assert(last_response.body.include?('Press <b>Next</b> for Human O\'s move.'))
    assert(last_response.body.include?('<button><a href=/play_human>Next</a></button>'))
  end

  def test_play_ai_game_over
    get '/'  # use to instantiate objects and initialize variable sessions
    assert(last_response.ok?)
    post '/players', player_type: {"p1_type"=>"Sequential", "p2_type"=>"Human"}
    assert(last_response.ok?)
    get '/game_over_test'  # route to seed game.round and board.game_board
    assert(last_response.ok?)
    get '/play_ai'  # verify a (get '/' do) route exists - doesn't need erb statement to pass
    # output = last_response.to_a  # use to put last_response object data in an array
    # puts "last response: #{output}"  # use to make last_response data visible for seeing errors
    assert(last_response.ok?)  # verify server response == 200 for (get '/') action - doesn't need erb statement to pass
    assert(last_response.body.include?('Round 5'))
    assert(last_response.body.include?('Sequential X won the game!'))
    assert(last_response.body.include?('The winning positions were: t1, t2, t3'))
    assert(last_response.body.include?('Press <b>Play</b> to start a new game.'))
  end

  def test_play_human_round_1
    get '/'  # use to instantiate objects and initialize variable sessions
    assert(last_response.ok?)
    post '/players', player_type: {"p1_type"=>"Human", "p2_type"=>"Random"}
    assert(last_response.ok?)
    get '/play_human'  # verify a (get '/' do) route exists - doesn't need erb statement to pass
    # output = last_response.to_a  # use to put last_response object data in an array
    # puts "last response: #{output}"  # use to make last_response data visible for seeing errors
    assert(last_response.ok?)  # verify server response == 200 for (get '/') action - doesn't need erb statement to pass
    assert(last_response.body.include?('Round 1'))
    assert(last_response.body.include?('It\'s Human X\'s move!'))
    assert(last_response.body.include?('Please select a location and press <b>Submit</b>.'))
    assert(last_response.body.include?('<form method="post" action="result_human">'))
    assert(last_response.body.include?('<select type="text" name="location">'))
    assert(last_response.body.include?('<option value="t1">t1 (top left)</option>'))
    assert(last_response.body.include?('<option value="t2">t2 (top center)</option>'))
    assert(last_response.body.include?('<option value="t3">t3 (top right)</option>'))
    assert(last_response.body.include?('<option value="m1">m1 (middle left)</option>'))
    assert(last_response.body.include?('<option value="m2">m2 (middle center)</option>'))
    assert(last_response.body.include?('<option value="m3">m3 (middle right)</option>'))
    assert(last_response.body.include?('<option value="b1">b1 (bottom left)</option>'))
    assert(last_response.body.include?('<option value="b2">b2 (bottom center)</option>'))
    assert(last_response.body.include?('<option value="b3">b3 (bottom right)</option>'))
  end

  def test_result_human_round_1
    get '/'  # use to instantiate objects and initialize variable sessions
    assert(last_response.ok?)
    post '/players', player_type: {"p1_type"=>"Human", "p2_type"=>"Sequential"}
    assert(last_response.ok?)
    get '/play_human'
    assert(last_response.ok?)
    post '/result_human', location: "b3"
    # output = last_response.to_a  # use to put last_response object data in an array
    # puts "last response: #{output}"  # use to make last_response data visible for seeing errors
    assert(last_response.ok?)  # verify server response == 200 for (get '/') action - doesn't need erb statement to pass
    assert(last_response.body.include?('Round 1'))
    assert(last_response.body.include?('Human X took b3 in round 1.'))
    assert(last_response.body.include?('Press <b>Next</b> for Sequential O\'s move.'))
    assert(last_response.body.include?('<button><a href=/play_ai>Next</a></button>'))
  end

  def test_result_human_location_already_taken
    get '/'  # use to instantiate objects and initialize variable sessions
    assert(last_response.ok?)
    post '/players', player_type: {"p1_type"=>"Human", "p2_type"=>"Sequential"}
    assert(last_response.ok?)
    get '/play_human'
    assert(last_response.ok?)
    get '/location_taken_test'  # route to seed game.round and board.game_board
    assert(last_response.ok?)
    post '/result_human', location: "t1"
    # output = last_response.to_a  # use to put last_response object data in an array
    # puts "last response: #{output}"  # use to make last_response data visible for seeing errors
    assert(last_response.ok?)  # verify server response == 200 for (get '/') action - doesn't need erb statement to pass
    assert(last_response.body.include?('Round 3'))
    assert(last_response.body.include?('That position isn\'t open. Try again Human X.'))
    assert(last_response.body.include?('Please select a location and press <b>Submit</b>.'))
    assert(last_response.body.include?('<form method="post" action="result_human">'))
    assert(last_response.body.include?('<select type="text" name="location">'))
    assert(last_response.body.include?('<option value="t1">t1 (top left)</option>'))
    assert(last_response.body.include?('<option value="t2">t2 (top center)</option>'))
    assert(last_response.body.include?('<option value="t3">t3 (top right)</option>'))
    assert(last_response.body.include?('<option value="m1">m1 (middle left)</option>'))
    assert(last_response.body.include?('<option value="m2">m2 (middle center)</option>'))
    assert(last_response.body.include?('<option value="m3">m3 (middle right)</option>'))
    assert(last_response.body.include?('<option value="b1">b1 (bottom left)</option>'))
    assert(last_response.body.include?('<option value="b2">b2 (bottom center)</option>'))
    assert(last_response.body.include?('<option value="b3">b3 (bottom right)</option>'))
  end

  def test_result_human_game_over
    get '/'  # use to instantiate objects and initialize variable sessions
    assert(last_response.ok?)
    post '/players', player_type: {"p1_type"=>"Human", "p2_type"=>"Sequential"}
    assert(last_response.ok?)
    get '/play_human'
    assert(last_response.ok?)
    get '/game_over_test'  # route to seed game.round and board.game_board
    assert(last_response.ok?)
    post '/result_human', location: "t3"
    # output = last_response.to_a  # use to put last_response object data in an array
    # puts "last response: #{output}"  # use to make last_response data visible for seeing errors
    assert(last_response.ok?)  # verify server response == 200 for (get '/') action - doesn't need erb statement to pass
    assert(last_response.body.include?('Round 5'))
    assert(last_response.body.include?('Human X won the game!'))
    assert(last_response.body.include?('The winning positions were: t1, t2, t3'))
    assert(last_response.body.include?('Press <b>Play</b> to start a new game.'))
  end

end