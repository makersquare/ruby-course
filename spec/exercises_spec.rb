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

describe 'Exercise 3' do
  it "returns the sum of the given array of numbers" do
    result = Exercises.ex3([4, 5, 7, 9])

    expect(result).to eq(25)
  end
end

describe 'Excercise 4' do
  it "returns the max number of the given array" do 
    result = Exercises.ex4([4, 5, 7, 9])

    expect(result).to eq(9)
  end
end

describe 'Excercise 5' do
  xit "iterates through an array and `puts` each element" do
    result = Exercises.ex5([4, 5, 7, 9])

    expect(result).to eq("4579")
  end
end

describe 'Exercise 6' do
  it "last item n array to 'panda',If the last already 'panda', update to 'GODZILLA'" do
    result1 = Exercises.ex6(["blah", "blah", "blah", "panda"])
    result2 = Exercises.ex6(["blah", "blah", "blah", "blah"])

    expect(result1).to eq(["blah", "blah", "blah", "GODZILLA"])
    expect(result2).to eq(["blah", "blah", "blah", "panda"])
  end
end

describe 'Exercise 8' do
  it "Iterate through people_hash and print out their name and occupation." do
    result1 = Exercises.ex8([{:name => 'Bob', :occupation => 'Builder' }])

    expect(result1).to eq("Bob the Builder")


  end
end









