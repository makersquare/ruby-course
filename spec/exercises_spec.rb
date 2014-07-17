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
    xit "returns the number of elements in the array" do
      result = Exercises.ex1(array)
      expect(result).to be(array.count)
    end
  end

  context "Exercise 3" do  
    xit "returns the number of elements in the array" do
      result = Exercises.ex1(array)
      expect(result).to be(array.count)
    end
  end

  context "Exercise 4" do  
    xit "returns the number of elements in the array" do
      result = Exercises.ex1(array)
      expect(result).to be(array.count)
    end
  end

  context "Exercise 5" do  
    xit "returns the number of elements in the array" do
      result = Exercises.ex1(array)
      expect(result).to be(array.count)
    end
  end

  context "Exercise 6" do  
    xit "returns the number of elements in the array" do
      result = Exercises.ex1(array)
      expect(result).to be(array.count)
    end
  end

  context "Exercise 7" do  
    xit "returns the number of elements in the array" do
      result = Exercises.ex1(array)
      expect(result).to be(array.count)
    end
  end

  context "Exercise 8" do  
    xit "returns the number of elements in the array" do
      result = Exercises.ex1(array)
      expect(result).to be(array.count)
    end
  end

  context "Exercise 9" do  
    xit "returns the number of elements in the array" do
      result = Exercises.ex1(array)
      expect(result).to be(array.count)
    end
  end



end