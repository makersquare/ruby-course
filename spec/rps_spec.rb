require './rps'

describe RPS do
	describe ".initialize" do
		it "sets the players names" do
			game = RPS.new('Bonnie', 'Clyde')
			expect(game.player1).to eq "Bonnie"
			expect(game.player2).to eq "Clyde"
		end
	end
end