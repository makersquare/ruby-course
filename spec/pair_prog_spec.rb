# Pair programming with Rui Nakata and Joseph Tingsanchali, 6/10/14

require 'pry-byebug'
require "./exercises.rb"
#require 'spec_helper'

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

describe "Exercise 1" do
	it "returns the nunber of elements in the array" do
		array = [1,2,3]
		expect(Exercises.ex1(array)).to eq(3)
	end
end

describe "Exercise 2" do
	it "returns the second element of an array" do
		array = [1,2,3]
		expect(Exercises.ex2(array)).to eq(2)
	end
end

describe "Exercise 3" do
	it "returns the sum of the given array of numbers" do
		array = [1,2,3]
		expect(Exercises.ex3(array)).to eq(6)
	end
end

describe "Exercise 4" do
	it "returns the max number of the given array" do
		array = [1,2,3]
		expect(Exercises.ex4(array)).to eq(3)
	end
end


describe "Exercise 5" do
	it "iterates through an array and puts each element" do
		array=[1,2,3]
		# Exercises.ex5(array).should_receive(:puts).with("1", "2", "3")
		expect(STDOUT).to receive(:puts).with(1)
		expect(STDOUT).to receive(:puts).with(2)
		expect(STDOUT).to receive(:puts).with(3)
		Exercises.ex5(array)
	end
end

describe "Exercise 6" do
	it "updates last item in array to 'panda'" do
		array = [1,2,3]
		expect(Exercises.ex6(array).last).to eq('panda')
	end

	it "if last already 'panda', update to 'GODZILLA' instead" do
		array2 = [1,2,'panda']
		expect(Exercises.ex6(array2).last).to eq('GODZILLA')
	end
end

describe "Exercise 7" do
	it "If the string str exists in the array, add `str` to the end of the array" do
		str = "str"
		array = [1,2, "str"]
		array2 = [1,2]
		expect(Exercises.ex7(array, str)).to eq([1,2,"str", "str"])
		expect(Exercises.ex7(array2, str)).to eq([1,2])
	end
end

describe "Exercise 8" do
	it "iterate through 'people' and print out their name and occupation" do
		people = [{ :name => 'Bob', :occupation => 'Builder' }, { :name => 'Joey', :occupation => 'burger flipper'}]
		expect(STDOUT).to receive(:puts).with('Bob: Builder')
		expect(STDOUT).to receive(:puts).with('Joey: burger flipper')
		Exercises.ex8(people)
	end
end

describe "Exercise 9" do
	it "return 'true' if given time is in leap year, otherwise return 'false'" do
		time = 2012
		time2 = 1800
		expect(Exercises.ex9(time)).to eq(true)
		expect(Exercises.ex9(time2)).to eq(false)
	end
end

describe "RPS" do
  it "initializes with two player names" do
  	rps = RPS.new("Rui", "Joseph")
    expect(rps.player1).to eq("Rui")
    expect(rps.player2).to eq("Joseph")
  end

  it "correctly figures out the winner" do
  	rps = RPS.new("Rui", "Joseph")
  	expect(STDOUT).to receive(:puts).with("Joseph wins!")
  	rps.play("rock", "paper")
  	expect(STDOUT).to receive(:puts).with("Tie")
  	rps.play("paper", "paper")
  end

  it "correctly determines if a player wins 2 of 3 games" do
  	rps = RPS.new("Rui", "Joseph")
  	rps.play("rock", "rock")
  	rps.play("rock", "paper")
  	expect(STDOUT).to receive(:puts).with("Joseph wins!")
  	expect(STDOUT).to receive(:puts).with("Joseph wins the game")
  	rps.play("rock", "paper")
  end
end





























