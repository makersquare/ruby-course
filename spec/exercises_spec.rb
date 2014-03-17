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

  it 'returns the number of elements in the array'
    result = Exercises.ex1([1,2,3])
    result2 = Exercises.ex1(['a','b','c','d','e'])
    expect(result).to eq 3
    expect(result1).to eq 5
  end


end
