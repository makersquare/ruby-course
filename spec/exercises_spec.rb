require "./exercises.rb"
require 'pry-byebug'

describe Exercises do 
  describe '.ex0' do
    it 'returns "nope" if the string passed in is "wishes"' do
      string = "wishes"

      expect(Exercises.ex0(string)).to eq("nope")
    end

    it 'triples a string otherwise' do
      string = "triple"

      expect(Exercises.ex0(string)).to eq("tripletripletriple")
    end
  end

  describe '.ex1' do
    it 'returns the number of elements inside of array' do
      array1 = [1,2,3]
      array2 = []

      expect(Exercises.ex1(array1)).to eq(3)
      expect(Exercises.ex1(array2)).to eq(0)
    end
  end

  describe '.ex2' do
    it 'returns the second element of an array' do
      array1 = [1,2,3,4,5,6]

      expect(Exercises.ex2(array1)).to eq(array1[1])
    end

    it 'returns nil if array size is less than 2' do
      array2 = [1]

      expect(Exercises.ex2(array2)).to be_nil
    end
  end

end