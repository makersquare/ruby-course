require 'pry-byebug'
require "./exercises.rb"


describe Exercises do

  it 'triples a given string' do
    Exercises.ex0('blah').should eq('blahblahblah')
  end

  it 'returns nope if the string is wishes' do
    Exercises.ex0('wishes').should eq('nope')
  end
end