require 'pry-debugger'
require "./exercises.rb"

describe Exercises do
  it 'triples a given string' do
    result = Exercises.self.ex0('ha')
    expect(result).to eq 'hahaha'
  end
end
