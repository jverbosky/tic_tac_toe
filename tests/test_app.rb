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
  end

  def test_post_players
    post '/players', player_type: {"p1_type"=>"Perfect", "p2_type"=>"Human"}
    # assert(last_response.ok?)
    # assert(last_response.body.include?('Got it!'))
    # assert(last_response.body.include?('X is Random and O is Perfect.'))
    # assert(last_response.body.include?('Press Play to begin the game'))
    # assert(last_response.body.include?('<button<a href=/play_ai>Play</a></button>'))
  end

end