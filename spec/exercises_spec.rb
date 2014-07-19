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
    result = Exercises.ex1([1, 2, "cats", 5.1])
    expect(result).to eq 4
  end
end

describe 'Exercise 2' do
  
  it "returns the second element of an array" do
    result = Exercises.ex2([1, "block", 3, 4.9, "win"])
    expect(result).to eq('block')
  end
end

describe 'Exercise 3' do

  it "returns the sum of the given array of numbers" do 
    result = Exercises.ex3([1, 2, 3, 4, 5])
    expect(result).to eq(15)
  end
end

describe 'Exercise 4' do

  it "returns the max number of the given array" do
    result = Exercises.ex4([1, 2, 3, 42, 75, 23])
    expect(result).to eq(75)
  end
end
