require "./exercises.rb"
require 'pry-byebug'

describe 'self.ex0' do
  it 'triples the lengths of a string' do
    result = Exercises.ex0("ha")
    expect(result).to eq("hahaha")
  end

  it "returns 'nope' if the string is 'wishes'" do
    result = Exercises.ex0("wishes")
    expect(result).to eq("nope")
  end
end

describe 'self.ex1' do
  it 'returns the number of elements in the array' do
    result = Exercises.ex1([1,2,3])
    expect(result).to eq(3)
  end
end

describe 'self.ex2' do
  it 'returns the second element of the array' do
    result = Exercises.ex2([1,2,3])
    expect(result).to eq(2)
  end
end

describe 'self.ex3' do
  it 'returns the sum of the given array of numbers' do
    result = Exercises.ex3([1,2,3])
    expect(result).to eq(6)
  end
end

describe 'self.ex4' do
  it 'returns the largest number in the array' do
    result = Exercises.ex4([1,2,5,2])
    expect(result).to eq(5)
  end
end

describe 'self.ex5' do
  it 'puts every element in the array' do
    expect(STDOUT).to receive(:puts).and_return("1")
    expect(STDOUT).to receive(:puts).and_return("2")
    expect(STDOUT).to receive(:puts).and_return("3")
    # expect($stdout.to_i).to eq(1)
    # expect($stdout.to_i).to eq(2)
    # expect($stdout.to_i).to eq(3)
    Exercises.ex5([1,2,3])
  end
end

describe 'self.ex6' do
  it 'updates the last item in the array to panda' do
    result = Exercises.ex6([1,2,3,4])
    expect(result).to eq("panda")
  end

  it 'if the last item is panda, instead updates to godzilla' do
    result = Exercises.ex6([1,2,3,"panda"])
    expect(result).to eq("GODZILLA")
  end
end

describe 'self.ex7' do
  it 'adds str to the end of the array if it exists in the array' do
    result = Exercises.ex7(["ape", "monkey"], "ape")
    expect(result).to eq(["ape", "monkey", "ape"])
  end
end

describe 'self.ex8' do
  it 'prints out name and occupation from the hash' do
    expect(STDOUT).to receive(:puts).and_return("Bob")
    expect(STDOUT).to receive(:puts).and_return("Builder")
    expect(STDOUT).to receive(:puts).and_return("John")
    expect(STDOUT).to receive(:puts).and_return("Carpenter")
  
    Exercises.ex8([{name: "bob", occupation: "builder"},{name: "John", occupation: "Carpenter"}])
  end  
end

describe 'self.ex9' do
  it 'requires an argument that is a time object' do
    result = Exercises.ex9(1)
    expect(result).to eq(nil)
  end

  it 'returns true if a year is a leap year' do
    result = Exercises.ex9(Time.new(2012))
    expect(result).should be(true)
  end

  it 'returns false if a year is not a leap year' do
    result = Exercises.ex9(Time.new(2011))
    expect(result).should be(false)
  end
end


