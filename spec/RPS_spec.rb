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

  it "keeps score" do
    winner = @newGame.play("rock","scissors")
    expect(@newGame.playerOneScore).to eq(1)
    expect(@newGame.playerTwoScore).to eq(0)
  end


  it "returns 'Game is Over' if the game is over" do
    winner = @newGame.play("rock", "scissors")
    winner = @newGame.play("scissors", "rock")
  end

  it "returns 'Tie Try Again' if there's a tie" do
    winner = @newGame.play("rock", "rock")
    expect(winner).to eq("Tie Try Again")
  end

  it "ends after a player wins 2 of 3 rounds" do
    winner = @newGame.play("paper","rock")
    winner = @newGame.play("scissors","rock")
    winner = @newGame.play("rock","scissors")

    expect(@newGame.gameOver).to eq(true)
  end

  it "returns the correct winner" do
    winner = @newGame.play("paper","rock")
    winner = @newGame.play("paper","rock")

    expect(winner).to eq("Bob Wins the Game")
    expect(@newGame.gameWinner).to eq("Player One")
  end

end
