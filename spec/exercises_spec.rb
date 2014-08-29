# require 'rubygems'
require 'rspec'
# require 'pry-byebug'
require_relative '../exercises.rb'

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
  it "checks the length of an empty array" do
    result = Exercises.ex1([])
    expect(result).to eq(0)
  end

  it "checks the length of a single-element array" do
    result = Exercises.ex1([1])
    expect(result).to eq(1)
  end

  it "checks the length of a multiple-element array" do
    result = Exercises.ex1([1,2,3,4])
    expect(result).to eq(4)
  end

  it "checks the length of an array with variable elements" do
    array = [1, "b", :c, {}, []]
    result = Exercises.ex1(array)
    expect(result).to eq(5)
  end
end

describe 'Exercise 2' do
  it "returns the second element of an array" do
    array = [1, 2, 3]
    result = Exercises.ex2(array)
    expect(result).to eq(2)
  end

  it "returns nil if there's no second element of an array" do
    result = Exercises.ex2([])
    expect(result).to be_nil
  end
end

describe 'Exercise 3' do
  it "returns the sum of the given array of numbers" do
    array = [1,2,3,4,5]
    result = Exercises.ex3(array)
    expect(result).to eq(15)
  end

  it "returns the sum of the given array of any numbers" do
    array = [1,2,3,4,-5]
    result = Exercises.ex3(array)
    expect(result).to eq(5)
  end
end

describe 'Exercise 4' do
  it "Returns the max number of the given array" do
    array = [1,2,3,4,-5]
    result = Exercises.ex4(array)
    expect(result).to eq(4)
  end

  it "Returns nil for an empty array" do
    result = Exercises.ex4([])
    expect(result).to be_nil
  end
end

# describe 'Exercise 5' do
#   it "triples the length of a string" do
#   end
# end

# describe 'Exercise 6' do
#   it "triples the length of a string" do
#   end
# end

# describe 'Exercise 7' do
#   it "triples the length of a string" do
#   end
# end

# describe 'Exercise 8' do
#   it "triples the length of a string" do
#   end
# end

# describe 'Exercise 9' do
#   it "triples the length of a string" do
#   end
# end

# describe 'Exercise 10' do
#   it "triples the length of a string" do
#   end
# end
