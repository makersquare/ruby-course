require "./exercises.rb"
require 'pry-byebug'
# require 'spec_helper'

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
  it "counts the number of elements in an array" do
    result = Exercises.ex1([1,2,3,4])
    expect(result).to eq(4)
  end
end

describe 'Exercise 2' do
  it "returns the second element of the array" do
    result = Exercises.ex2([1,2,3,4,5])
    expect(result).to eq(2)
  end
end

describe 'Exercise 3' do
  it "returns the sum of an array of numbers" do
    result = Exercises.ex3([1,2,3,4])
    expect(result).to eq(10)
  end
end

describe 'Exercise 4' do
  it "returns the maximum of an array of numbers" do
    result = Exercises.ex4([1,2,5,3,7])
    expect(result).to eq(7)
  end
end

describe 'Exercise 5' do
  it "puts all elements of the array" do
    result = Exercises.ex5([1,2,3,4])
    expect(result).to eq([1, 2, 3, 4])
  end
end
