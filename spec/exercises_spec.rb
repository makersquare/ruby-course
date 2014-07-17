require 'pry-byebug'
require "./exercises.rb"


describe Exercises do
  before(:each) do
    @arr = [1,2,3]
  end

  it 'triples a given string' do
    Exercises.ex0('blah').should eq('blahblahblah')
  end

  it 'returns nope if the string is wishes' do
    Exercises.ex0('wishes').should eq('nope')
  end

  it 'returns the number of elements in an array' do
    Exercises.ex1(@arr).should eq(3)
  end

  it 'returns the second element of an array' do
    Exercises.ex2(@arr).should eq(2)
  end

  it 'returns the sum of the given array of numbers' do
    Exercises.ex3(@arr).should eq(6)
  end

  it 'returns the max number in a given array' do
    Exercises.ex4(@arr).should eq(3)
  end
end