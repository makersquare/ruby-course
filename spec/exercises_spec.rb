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

describe 'Exercise 2' do
	it "returns the second element of an array" do
		ary = [0,1,2,3,4]
		item_2 = Exercises.ex2(ary)
		expect(item_2).to eq(1)
	end
end

describe 'Exercise 3' do
	it "returns the sum of the given array of numbers" do
		ary = [1,2,3,4,5]
		result = Exercises.ex3(ary)
		expect(result).to eq(15)
	end
end

describe 'Exercise 4' do
	it "returns the max number of an array" do
		ary = [1,2,3,4,5,600,7]
		result = Exercises.ex4(ary)
		expect(result).to eq(600)
	end
end