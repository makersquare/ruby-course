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