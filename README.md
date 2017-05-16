## Tic Tac Toe ##

A web app developed using Ruby, Sinatra, HTML and CSS.

Highlights include:

1. A mobile device friendly UI.
2. Support for human and four different types of computer opponents (two unbeatable).
3. Human player move validation.
4. Dynamic game play details after each round.
5. Cumulative scoring for multiple games.

----------

## Gameplay ##

Please refer to the following sections for details on how to run and play the game:

- Running the Game
- Player Selection
- Move Selection
- Cumulative Scoring

----------

**Running the Game**

----------

To open the game from any Internet-connected device, use the following URL:

[https://tic-tac-toe-jv.herokuapp.com](https://tic-tac-toe-jv.herokuapp.com)

----------

To run the game locally:

1. Make sure that [Ruby](https://www.ruby-lang.org/en/documentation/installation/) is installed.
2. Make sure that the [Sinatra](https://github.com/sinatra/sinatra) gem is installed.  *Note that installing the Sinatra gem will install other gems necessary to run the game locally, such as rack.*
3. Navigate to the directory which contains **app.rb** in a terminal (command prompt) session.
4. Run the following command to launch the Sinatra web server:

	`rackup`

To open the game locally once it is running via *rackup*, use the following URL:

[http://localhost:9292](http://localhost:9292/)

----------

**Player Selection**

----------

1. On the initial screen, use the **Player 1 (X)** and **Player 2 (O)** drop-downs to specify the desired player type.

	**Human** - a human player where moves can be specified by the player

	**Perfect** - a more aggressive unbeatable computer player that selects the most optimal positions based upon pattern matching

	**Random** - a computer player that randomly selects an open position

	**Sequential** - a computer player that selects the next open position

	**Unbeatable** - an unbeatable computer player based on Newell and Simon's tic-tac-toe program [rules](https://en.wikipedia.org/wiki/Tic-tac-toe#Strategy)

2. Click the **Submit** button.
3. On the subsequent screen, confirm the selected player types and press the **Play** button when ready to play.

----------

**Move Selection**

----------

- Human players:

	1. Use the drop-down to specify the desired location.
	2. Select the **Submit** button.
	3. On the subsequent move summary screen, select the **Next** button to advance to the next player's move.<br>

- Computer players:

	1. The computer player's move will be reflected.
	2. Select the **Next** button on the move summary screen to advance to the next player's move.

----------

**Cumulative Scoring**

----------

- If player X or O wins a game, the corresponding **X Score** or **O Score** at the top of the screen will be incremented by 1 accordingly.
- If the game ends in a tie, neither score will be incremented.

----------

## Tests ##

Please refer to the following sections for details on how to run the unit and front-end tests for the web app.

----------

**Unit and Front-End Tests Overview**

----------

Tests have been developed to verify that the methods in each class file and routes/views in the web app are working as intended.  All tests are located in the **/tests** directory.

Unit Tests:

- **test_board.rb** > **/board/board.rb** (8 tests)
- **test_game.rb** > **/game/game.rb** (34 tests)
- **test_messaging.rb** > **/game/messaging.rb** (13 tests)
- **test\_player_perf.rb** > **/players/player\_perf.rb** (105 tests)
- **test\_player\_perf_ns.rb** > **/players/player\_perf\_ns.rb** (106 tests)
- **test\_player_rand.rb** > **/players/player\_rand.rb** (2 tests)
- **test\_player_seq.rb** > **/players/player\_seq.rb** (5 tests)
- **test_position.rb** > **/board/position.rb** (11 tests)
- **test_win.rb** > **/game/win.rb** (11 tests)

Front-End Tests:

- **test_app.rb** > **/app.rb** (8 tests, 86 assertions)

----------

**Preparing to Run Tests**

----------
In order to seed values and leverage helper methods, some tests require greater access to instance variables within a class than is required to simply run the web app.

As a result, some classes have additional "unit test" versions of *attr\_accessor* and *attr\_reader* statements.  These  are identified by a **# user for unit testing** comment, and need to be used instead of  the default *attr\_accessor* and *attr\_reader* statements prior to running any associated unit tests.

For example, the non-testing *attr\_accessor* and *attr\_reader* statements in **/board/board.rb** are:

	attr_reader :game_board
	# attr_accessor :game_board  # use for unit testing

However, prior to running **/tests/test_board.rb** against **/board/board.rb**, these statements must be changed as follows:

	# attr_reader :game_board
	attr_accessor :game_board  # use for unit testing

Note that the required statements are specified in the comments at the top of each unit test file.  For example, the following comments are at the top of **/tests/test\_board.rb**:

    # be sure to use the unit test version of attr_ in /board/board.rb
    # - attr_accessor in /board/board.rb

----------

**Running Unit Tests**

----------

Once the required "unit test" versions of *attr\_accessor* and *attr\_reader* statements are available, unit tests can be run by doing the following:

1. Navigate to the **/tests** directory in a terminal (command prompt) session
2. Run the following command for the desired unit test:<br>

    ruby *test\_file_name.rb*

For example, to run the unit tests for **board.rb** (the Board class), run the following command from the **/tests** directory:

	ruby test_board.rb

The resulting output will indicate the success of the unit tests:

    Run options: --seed 30690
    
    # Running:
    
    ........

    Finished in 0.003401s, 2351.9693 runs/s, 2351.9693 assertions/s.

    8 runs, 8 assertions, 0 failures, 0 errors, 0 skips

----------

**Running Front-End Tests**

----------

The **/tests/test\_app.rb** file contains front-end tests for the web app routes (**app.rb**) and associated views (for example, **/views/start.erb**).

As with the unit tests, the required "unit test" versions of *attr\_accessor* and *attr\_reader* statements must be used (this time in **/board/board.rb** and **/game/game.rb**).  Once the required "unit test" versions of *attr\_accessor* and *attr\_reader* statements are available, front-end tests can be run by doing the following:

1. Navigate to the **/tests** directory in a terminal (command prompt) session.
2. Run the following command for the front-end test:

	`ruby test_app.rb`

The resulting output will indicate the success of the front-end tests and assertions:

    Run options: --seed 62486
    
    # Running:
    
    ........
    
    Finished in 0.208696s, 38.3332 runs/s, 412.0819 assertions/s.
    
    8 runs, 86 assertions, 0 failures, 0 errors, 0 skips

----------

Enjoy!