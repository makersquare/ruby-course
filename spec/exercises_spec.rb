require './exercises.rb'
require 'pry-debugger'

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

describe 'Exercise 5' do
	it "iterates through an array and `puts` each element" do
		ary = [1,2,3,4,5]
		expect(STDOUT).to receive(:puts).with(1)
		expect(STDOUT).to receive(:puts).with(2)
		expect(STDOUT).to receive(:puts).with(3)
		expect(STDOUT).to receive(:puts).with(4)
		expect(STDOUT).to receive(:puts).with(5)
		result = Exercises.ex5(ary)
	end
end

describe 'Exercise 6' do
	it "updates the last item in the array to 'panda'" do
		ary = [1,2,3,4,5]
		str = "panda"
		result = Exercises.ex6(ary, str)
		expect(result).to eq("panda")
	end

	it "updates the last item in the array to GODZILLA if the last item is already 'panda'" do
		ary = [1,2,3,4,"panda"]
		str = "panda"
		result = Exercises.ex6(ary, str)
		expect(result).to eq("GODZILLA")
	end
end

describe 'Exercise 7' do
	it "adds a string to an array if the string `str` exists in the array" do
		ary = [1,2,3,4,"panda"]
		str = "panda"
		result = Exercises.ex7(ary, str)
		new_ary = [1,2,3,4,"panda", "panda"]
		expect(result).to eq(new_ary)
	end
end

describe 'Exercise 8' do
	it "iterates through an array of hashes and prints out their key / value pairs" do
    	bob = { :name => 'Bob', :occupation => 'Builder' }
    	antonio = { :name => 'Antonio', :occupation => 'Developer' }
    	henry = { :name => 'Henry', :occupation => 'Farmer' }
    	people = [bob, antonio, henry]
    	expect(STDOUT).to receive(:puts).with("Bob", "Builder")
    	expect(STDOUT).to receive(:puts).with("Antonio", "Developer")
    	expect(STDOUT).to receive(:puts).with("Henry", "Farmer")
    	result = Exercises.ex8(people)
    end
end

describe 'Exercise 9' do
	it "returns `true` if the given time is in a leap year" do
		time = Time.new
		Time.stub(:now).and_return(time)
		result = Exercises.ex9(time)
		expect(result).to eq(false)
	end
end