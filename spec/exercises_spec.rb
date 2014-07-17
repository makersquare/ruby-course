require 'pry-byebug'
require './exercises.rb'

describe 'Exercises' do

  context "Exercise 0" do
    it "triples the length of a string" do
      result = Exercises.ex0("ha")
      expect(result).to eq("hahaha")
    end

    it "returns 'nope' if the string is 'wishes'" do
      result = Exercises.ex0("wishes")
      expect(result).to eq("nope")
    end
  end
    
  context "Exercise 1" do  
    it "returns the number of elements in the array" do
      result = Exercises.ex1([1,2,3])
      expect(result).to be(3)
    end
  end

  context "Exercise 2" do  
    it "returns the second element of an array" do
      result = Exercises.ex2([1,2,3])
      expect(result).to be(3)
    end
  end

  context "Exercise 3" do  
    it "Returns the sum of the given array of numbers" do
      result = Exercises.ex3([1,2,3])
      expect(result).to be(6)
    end
  end

  context "Exercise 4" do  
    it "Returns the max number of the given array" do
      result = Exercises.ex4([1,2,3])
      expect(result).to be(3)
    end
  end

  context "Exercise 5" do  
    it "Iterates through an array and `puts` each element" do
      expect(STDOUT).to receive(:puts).and_return("1")
      expect(STDOUT).to receive(:puts).and_return("2")
      expect(STDOUT).to receive(:puts).and_return("3")
      expect(STDOUT).to receive(:puts).and_return("4")
      Exercises.ex5([1,2,3,4])
    end
  end

  context "Exercise 6" do  
    xit "Updates the last item in the array to 'panda'; If the last item is already 'panda', update; it to 'GODZILLA' instead" do
      result = Exercises.ex6(array)
      expect(result).to be(array.count)
    end
  end

  context "Exercise 7" do  
    xit "" do
      result = Exercises.ex7(array)
      expect(result).to be(array.count)
    end
  end

  context "Exercise 8" do  
    xit "" do
      result = Exercises.ex8(array)
      expect(result).to be(array.count)
    end
  end

  context "Exercise 9" do  
    xit "" do
      result = Exercises.ex9(array)
      expect(result).to be(array.count)
    end
  end



end