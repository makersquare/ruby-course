
require "./exercises.rb"

describe 'Exercise'  do 
	it "triples the string of a string" do
		result = Exercises.ex0("ha")
		expect(result).to eq("hahaha")
	end

	it "returns 'nope' if the string is 'wishes" do
		result = Exercises.ex0("wishes")
		expect(result).to eq("nope")
	end

	it "returns the number of elements in the array" do
		result = Exercises.ex1([1,2,3])
		expect(result).to eq(3)
	end

	it "returns the second element of the array" do
		result = Exercise.ex2([1,2,3])
		expect(results).to eq(2)

	end
end