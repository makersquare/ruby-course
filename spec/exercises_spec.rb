require './exercises'

describe "Exercise 0" do
	it "Triples a given string" do
		result = Exercises.ex0('ho')
		expect(result).to eq 'hohoho'
	end
end