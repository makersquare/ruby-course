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
  it "initializes with 2 strings (player names)" do
  newGame = RPS.new("Bob", "Tom")
  expect(newGame.playerOne).to eq("Bob")
  expect(newGame.playerTwo).to eq("Tom")
  end
end
