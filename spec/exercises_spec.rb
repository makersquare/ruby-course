require './exercises'

describe "Exercise 0" do
	it "triples a given string" do
		result = Exercises.ex0('ho')
		expect(result).to eq 'hohoho'
	end

	it "returns 'nope' if string is 'wishes'" do
		result = Exercises.ex0('wishes')
		expect(result).to eq 'nope'
	end

	describe "Exercise 1" do
		it "returns the number of elements in the array" do
			animals = ['tiger', 'lion', 'crocodile', 'snake']
			result = Exercises.ex1(animals)
			expect(result).to eq(4)
		end
	end
end