require "./exercises.rb"
require 'pry-byebug'

describe 'Exercises' do

  describe '.ex0' do

    it 'should return three * the input string' do
      expect(Exercises.ex0("poo")).to eq ("poopoopoo")
    end

    it 'should return "nope" if the input string is "wishes"' do
      expect(Exercises.ex0("wishes")).to eq ("nope")
    end

  end

  describe '.ex1' do

    it 'returns the number of elements in the array' do
      expect(Exercises.ex1([1,2,3])).to eq(3)
    end

  end

  describe '.ex2' do

    it 'returns the second element of an array' do
      expect(Exercises.ex2([1,2,3])).to eq(2)
    end

  end

  describe '.ex3' do

    it 'returns the sum of the given array of numbers' do
      expect(Exercises.ex3([1,2,3])).to eq(6)
    end

  end

  describe '.ex4' do

    it 'returns the max number of the array' do
      expect(Exercises.ex4([1,2,3])).to eq(3)
    end

  end

  describe '.ex5' do

    it 'puts each element' do
      
      STDOUT.should_receive(:puts).with(1)
      STDOUT.should_receive(:puts).with(2)
      STDOUT.should_receive(:puts).with(3)
      
      Exercises.ex5([1,2,3])

    end

  end

  describe '.ex6' do

    it 'updates last array item to panda if it was not panda already' do
      expect(Exercises.ex6([1,2,3])).to eq ([1,2,'panda'])
    end

    it 'updates last array item to godzilla if it was already panda' do
      expect(Exercises.ex6([1,2,'panda'])).to eq ([1,2,'GODZILLA'])
    end

  end

  describe '.ex7' do

  end

  describe '.ex8' do

  end

  describe '.ex9' do

  end

  describe '.ex10' do

  end
  



end