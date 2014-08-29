require_relative '../exercises.rb'
require 'pry-byebug'
 

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
    result = Exercises.ex1([4, 5, 7, 9])
    

    expect(result).to eq(4)
  end
end

describe 'Exercise 2' do
  it "returns the second element of an array" do
  result = Exercises.ex2([4, 5, 7, 9])

  expect(result).to eq(5)
  end
end






