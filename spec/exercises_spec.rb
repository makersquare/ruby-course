require './exercises.rb'

describe 'Exercise 0' do
	it "triples the length of a string" do
		result = Exercises.ex0("ha")
		expect(result).to eq("hahaha")
	end

	it "returns 'nope' if the string is 'wishes'" do
		result = Exercises.ex0("wishes")
		expect(result).to eq("nope")
	end
end

describe 'Exercise 1' do
	it "returns the number of elements in the array" do
		ary = [1,2,3,4,5]
		array_count = Exercises.ex1(ary)
		expect(array_count).to eq(5)
	end
end