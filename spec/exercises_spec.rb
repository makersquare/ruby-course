require 'pry-debugger'
require "./exercises.rb"

describe Exercises do
  it 'triples a given string' do
    result = Exercises.ex0('ha')
    expect(result).to eq 'hahaha'
  end

  it 'returns "nope" if string is "wishes"' do
    result = Exercises.ex0('wishes')
    expect(result).to eq 'nope'
  end

  it 'returns the number of elements in the array' do
    result = Exercises.ex1([1,2,3])
    result2 = Exercises.ex1(['a','b','c','d','e'])
    expect(result).to eq 3
    expect(result2).to eq 5
  end

  it 'returns the second element of an array' do
    result = Exercises.ex2([1,2,3])
    result2 = Exercises.ex2(['a','b','c','d','e'])
    expect(result).to eq 2
    expect(result2).to eq 'b'
  end

  it 'returns the sum of an array of numbers' do
    result = Exercises.ex3([1,2,3])
    result2 = Exercises.ex3([10,10,10])
    expect(result).to eq 6
    expect(result2).to eq 30
  end

  it 'returns the max number of the given array' do
    result = Exercises.ex4([1,2,3])
    result2 = Exercises.ex4([10,9,8])
    expect(result).to eq 3
    expect(result2).to eq 10
  end

  it 'iterates through an array and puts each element' do
        expect(STDOUT).to receive(:puts).with("brandon")
        expect(STDOUT).to receive(:puts).with("beasley")
        Exercises.ex5(["brandon", "beasley"])
  end

  it 'updates the last item in the array to panda' do
    result = Exercises.ex6([1,2,3])
    expect(result).to eq [1,2,"panda"]
  end

end
