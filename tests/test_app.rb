require 'minitest/autorun'  # need for the Minitest::Test class
require 'rack/test'  # need for the Rack::Test::Methods mixin
require_relative '../app.rb'  # path to app file (one subdirectory higher than this file)
require_relative '../game/game.rb'

class TestApp < Minitest::Test  # TestApp subclass inherits from Minitest::Test class
  include Rack::Test::Methods  # Include the methods in the Rack::Test:Methods module (mixin)
  # Methods include: get, post, last_response, follow_redirect!

  def app
    TicTacToeApp  # most examples use App.new - reason why we don't need .new here?     ?????
  end

  class SessionData
    def initialize(cookies)
      @cookies = cookies
      @data = cookies['rack.session']
      if @data
        @data = @data.unpack("m*").first
        @data = Marshal.load(@data)
      else
        @data = {}
      end
    end

    def [](key)
      @data[key]
    end

    def []=(key, value)
      @data[key] = value
      session_data = Marshal.dump(@data)
      session_data = [session_data].pack("m*")
      @cookies.merge("rack.session=#{Rack::Utils.escape(session_data)}", URI.parse("//example.org//"))
      raise "session variable not set" unless @cookies['rack.session'] == session_data
    end
  end

  def session
    SessionData.new(rack_test_session.instance_variable_get(:@rack_mock_session).cookie_jar)
  end

  # def example_of_using_and_accessing_session_variables
  #   session[:game] = Game.new
  #   player_type = {"p1_type"=>"Perfect", "p2_type"=>"Human"}
  #   session[:game].select_players(player_type)  # initialize player objects based on player_type hash
  #   session[:p1_type] = session[:game].p1_type  # assign p1_type session to @p1_type in game.rb
  #   session[:p2_type] = session[:game].p2_type  # assign p1_type session to @p2_type in game.rb
  #   route = (session[:p1_type] == "Human") ? "/play_human" : "/play_ai"
  #   puts "route: #{route}"
  #   puts "round: #{session[:game].round}"
  # end

  # def test_get_entry_page
  #   get '/'  # verify a (get '/' do) route exists - doesn't need erb statement to pass
  #   assert(last_response.ok?)  # verify server response == 200 for (get '/') action - doesn't need erb statement to pass
  #   assert(last_response.body.include?('Please select the player types:'))
  #   assert(last_response.body.include?('<form method="post" action="players">'))
  #   assert(last_response.body.include?('<select type="text" name="player_type[p1_type]">'))
  #   assert(last_response.body.include?('<select type="text" name="player_type[p2_type]">'))
  #   assert(last_response.body.include?('<option value="Human">Human</option>'))
  #   assert(last_response.body.include?('<option value="Perfect">Perfect</option>'))
  #   assert(last_response.body.include?('<option value="Random">Random</option>'))
  #   assert(last_response.body.include?('<option value="Sequential">Sequential</option>'))
  # end

  def test_post_players
    # session[:game] = Game.new
    post '/players', player_type: {"p1_type"=>"Perfect", "p2_type"=>"Human"}
    # session[:game].select_players(player_type)
    # session[:p1_type] = session[:game].p1_type
    # session[:p2_type] = session[:game].p2_type
    # get '/players', params = {"p1_type"=>"Human", "p2_type"=>"Human"}
    # post '/players', player_type: {"p1_type"=>"Perfect", "p2_type"=>"Human"}
    # post '/players', player_type: {"p1_type"=>"Perfect", "p2_type"=>"Human"}
    output = last_response.to_a  # use to put last_response object data in an array
    puts "last response: #{output}"  # use to make last_response data visible for seeing errors
    assert(last_response.ok?)
    # game.p1_type = "Perfect"
    # assert(last_response.body.include?('Got it!'))
    # assert(last_response.body.include?('Perfect'))
    # assert(last_response.body.include?('Human'))
    # assert(last_response.body.include?('X is Perfect and O is Human.'))
    # assert(last_response.body.include?('Press Play to begin the game'))
    # assert(last_response.body.include?('<button<a href=/play_ai>Play</a></button>'))
  end

end