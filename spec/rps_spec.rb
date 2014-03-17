require './rps'

describe RPS do

	before do
	  @game = RPS.new('Bonnie', 'Clyde')
	end

	describe ".initialize" do
		it "sets the players names" do
			expect(@game.player1).to eq "Bonnie"
			expect(@game.player2).to eq "Clyde"
		end
	end

	describe "#play" do
		it "takes the players choices and returns a hand winner" do
			result = @game.play('rock', 'scissors')
			expect(result).to eq "rock beats scissors, Bonnie wins the hand!"
			expect(@game.game_wins).to eq(["Bonnie"])

			result = @game.play('rock', 'paper')
			expect(result).to eq "paper beats rock, Clyde wins the hand!"
			expect(@game.game_wins).to eq(["Bonnie", "Clyde"])

			result = @game.play('rock', 'rock')
			expect(result).to eq "This hand was a tie."
			expect(@game.game_wins).to eq(["Bonnie", "Clyde"])

			result = @game.play('scissors', 'rock')
			expect(result).to eq "rock beats scissors, Clyde wins the hand!"
			expect(@game.game_wins).to eq(["Bonnie", "Clyde", "Clyde"])
		end

		it "gives an error message if a player's choice is invalid" do
			result = @game.play('rock', 'shotgun')
			expect(result).to eq "Invalid choice. Enter 'rock', 'paper' or 'scissors'"
		end

		it "says a game is over after a player wins 2 out of 3 hands" do
			@game.game_wins = ["Bonnie", "Clyde", "Clyde"]
			result = @game.play('rock', 'paper')
			expect(result).to eq "Game over! Clyde wins the game."
		end
	end
end
