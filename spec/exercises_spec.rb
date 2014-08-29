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
    $stdout.should_receive(:puts).with(1)
    $stdout.should_receive(:puts).with(2)
    $stdout.should_receive(:puts).with(3)

    Exercises.ex5([1,2,3])
  end
end

describe 'Exercise 6' do
  it "Updates the last item in the array to 'panda'" do
    array = [1, 2, 3]
    result = Exercises.ex6(array)
    expect(array[-1]).to eq("panda")
  end
  it "updates the last item to 'GODZILLA' is the last item is 'panda'" do
    array = [1, 2, 'panda']
    result = Exercises.ex6(array)
    expect(array[-1]).to eq('GODZILLA')
  end
end

describe 'Exercise 7' do
  it "adds 'str' to the end of the array if 'str' exists in the array." do
    array = ["string1", "string2", "string3"]
    res = ["string1", "string2", "string3", "string1"]
    result = Exercises.ex7(array, "string1")
    expect(result).to eq(res)
  end
end

describe 'Exercise 8' do
  it "iterates through an array of hashes and prints out name and occupation" do
    array = [{ :name => 'Bob', :occupation => ' the Builder' }, { :name => 'Bill', :occupation => ' the Baker' }, { :name => 'Bo', :occupation => ' the Ball Player' }]
    $stdout.should_receive(:puts).with("Bob")
    $stdout.should_receive(:puts).with(" the Builder")
    $stdout.should_receive(:puts).with("Bill")
    $stdout.should_receive(:puts).with(" the Baker")
    $stdout.should_receive(:puts).with("Bo")
    $stdout.should_receive(:puts).with(" the Ball Player")

    result = Exercises.ex8(array)
  end
end