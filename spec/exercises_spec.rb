require './exercises.rb'
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
    result = Exercises.ex1([1,2,3])
    expect(result).to eq(3)
  end
end

describe 'Exercise 2' do
  it "returns the second element of an array" do
    result = Exercises.ex2([1,2,3])
    expect(result).to eq(2)
  end
end

describe 'Exercise 3' do
  it "Returns the sum of the given array of numbers" do
    result = Exercises.ex3([1,2,3])
    expect(result).to eq(6)
  end
end

describe 'Exercise 4' do
  it "Returns the max number of the given array" do
    result = Exercises.ex4([1,2,3])
    expect(result).to eq(3)
  end
end

describe 'Exercise 5' do
  it "Iterates through an array and `puts` each element" do
    result = Exercises.ex5([1,2,3])
    expect(result).to start_with(1)
    expect(result).to end_with(3)
  end
end