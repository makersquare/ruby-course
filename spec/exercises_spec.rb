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