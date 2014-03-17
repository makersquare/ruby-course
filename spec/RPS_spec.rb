  # Rock, Paper, Scissors
  # Make a 2-player game of rock paper scissors. It should have the following:
  #
  # It is initialized with two strings (player names).
  # It has a `play` method that takes two strings:
  #   - Each string reperesents a player's move (rock, paper, or scissors)
  #   - The method returns the winner (player one or player two)
  #   - If the game is over, it returns a string stating that the game is already over
  # It ends after a player wins 2 of 3 games
  #
  # You will be using this class in the following class, which will let players play
  # RPS through the terminal.

require './RPS.rb'

describe 'RPS' do
  before(:each) do
    @newGame = RPS.new("Bob", "Tom")
  end

  it "initializes with 2 strings (player names)" do
  expect(@newGame.playerOne).to eq("Bob")
  expect(@newGame.playerTwo).to eq("Tom")
  end

  it "has a play method that takes 2 strings (players moves) and returns the winner" do
    winner = @newGame.play("rock","scissors")
    expect(winner).to eq("Bob Wins the Round")
  end

  xit "keeps score" do
    winner = @newGame.play("rock","scissors")
    expect(playerOneScore).to eq(1)
    expect(playerTwoScore).to eq(0)
  end


  xit "returns 'Game is Over' if the game is over" do
  end

end
