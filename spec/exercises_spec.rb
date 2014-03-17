require './exercises'

describe "Exercise 0" do
	it "Triples a given string" do
		result = Exercises.ex0('ho')
		expect(result).to eq 'hohoho'
	end

	it "Returns 'nope' if string is 'wishes'" do
		result = Exercises.ex0('wishes')
		expect(result).to eq 'nope'
	end
end