require "./exercises.rb"
require 'pry-byebug'

describe Exercises do 
  describe '.ex0' do
    it 'returns "nope" if the string passed in is "wishes"' do
      string = "wishes"
      res = Exercises.ex0(string)

      expect(res).to eq("nope")
    end

    it 'triples a string otherwise' do
      string = "triple"
      res = Exercises.ex0(string)

      expect(res).to eq("tripletripletriple")
    end
  end

  describe '.ex1' do
    it 'returns the number of elements inside of array' do
      array1 = [1,2,3]
      array2 = []
      res1 = Exercises.ex1(array1)
      res2 = Exercises.ex1(array2)

      expect(res1).to eq(3)
      expect(res2).to eq(0)
    end
  end

  describe '.ex2' do
    it 'returns the second element of an array' do
      array1 = [1,2,3,4,5,6]
      res = Exercises.ex2(array1)

      expect(res).to eq(array1[1])
    end

    it 'returns nil if array size is less than 2' do
      array2 = [1]
      res = Exercises.ex2(array2)

      expect(res).to be_nil
    end
  end

  describe '.ex3' do
    it 'returns the sum of an array of numbers' do
      array = [1,2,3,4,5]
      sum = 15
      res = Exercises.ex3(array)

      expect(res).to eq(sum)
    end

    it 'returns nil if the array is empty' do
      array=[]
      res = Exercises.ex3(array)

      expect(res).to be_nil
    end
  end

  describe '.ex4' do
    it 'returns the max number of a given array' do
      array = [2,3,1,59,2,3,-1,32,42,900,2,3,1,0]
      res = Exercises.ex4(array)

      expect(res).to eq(900)
    end

    it 'returns nil if array is empty' do
    end
  end

  describe '.ex5' do
    it 'iterates through an array and puts each element' do
      array = [1,2,3,4,5]

      $stdout.should_receive(:puts).with(1)
      $stdout.should_receive(:puts).with(2)
      $stdout.should_receive(:puts).with(3)
      $stdout.should_receive(:puts).with(4)
      $stdout.should_receive(:puts).with(5)

      Exercises.ex5(array)
    end
  end

  describe '.ex6' do
    it 'updates the last item in the array to "panda" if not panda' do
      array = ["1", "2", "3", "4", 5]
      expectation = ["1", "2", "3", "4", "panda"]
      res = Exercises.ex6(array)

      expect(res).to eq(expectation)
    end

    it 'updates the last item in the array to GODZILLA if it is panda' do
      array = [1,2,3,4,"panda"]
      expectation = [1,2,3,4,"GODZILLA"]
      res = Exercises.ex6(array)

      expect(res).to eq(expectation)
    end
  end

  describe '.ex7' do
    it 'adds inputted string to end of array if it already exists in array' do
      str = "string"
      array = ["str", 2, "string", 3, "abc"]
      expectation = ["str", 2, "string", 3, "abc", "string"]
      res = Exercises.ex7(array, str)

      expect(res).to eq(expectation)
    end

    it "doesn't add the string if it isnt found" do
      str = "string"
      array = [1,2,3,4]
      res = Exercises.ex7(array, str)

      expect(res).to be_nil
    end
  end
end