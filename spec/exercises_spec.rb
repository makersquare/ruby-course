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

end
