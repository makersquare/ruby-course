require 'rubygems'
require 'rspec'
require_relative "../exercises.rb"

describe "Exercises" do
  it "should work" do
    expect(true).to eq(true)
  end

  describe "ex0" do
    it "triples the length of a string" do
      result = Exercises.ex0 "ha"
      expect(result).to eq("hahaha")
    end

    it "returns 'nope' if the string is 'wishes'" do
      result = Exercises.ex0 "wishes"
      expect(result).to eq("nope")
    end
  end

  describe "ex1" do
    it "should return 0 for an empty array" do
      result = Exercises.ex1 []
      expect(result).to eq(0)
    end

    it "should return the size of an array" do
      result = Exercises.ex1 [4, 3, 2, 5]
      expect(result).to eq(4)
    end
  end

  describe "ex2" do
    it "should return nil for an array shorter than 2 elements" do
      result = Exercises.ex2 []
      expect(result).to eq(nil)

      result = Exercises.ex2 [1]
      expect(result).to eq(nil)
    end

    it "should return the second element of a longer array" do
      result = Exercises.ex2 [4, 5]
      expect(result).to eq(5)

      result = Exercises.ex2 [1, 2, 3]
      expect(result).to eq(2)
    end
  end

  describe "ex3" do
    it "should sum up an array" do
      result = Exercises.ex3 [5,6,7]
      expect(result).to eq(18)
    end
  end

  describe "ex4" do
    it "should return the largest number in this array" do
      result = Exercises.ex4 [9,3,2,5]
      expect(result).to eq(9)
    end
  end

  describe "ex5" do
    it "should print every element in an array" do
      STDOUT.should_receive(:puts).with(1)
      STDOUT.should_receive(:puts).with(2)
      STDOUT.should_receive(:puts).with("b")
      STDOUT.should_receive(:puts).with("c")
      Exercises.ex5 [1, 2, 'b', 'c']
    end
  end

  describe "ex3" do
    it "doesn't change the array if it doesn't have str" do
      result = Exercises.ex7(["alpha", "beta", "gamma"], "hello")
      expect(result).to eq(["alpha", "beta", "gamma"])
    end

    it "adds str to the end of the array if its included" do
      result = Exercises.ex7(["alpha", "beta", "gamma"], "beta")
      expect(result).to eq(["alpha", "beta", "gamma", "beta"])
    end
  end

  describe "ex3" do
    it "should sum up an array" do
      result = Exercises.ex3 [5,6,7]
      expect(result).to eq(18)
    end
  end

  describe "ex3" do
    it "should sum up an array" do
      result = Exercises.ex3 [5,6,7]
      expect(result).to eq(18)
    end
  end

  describe "ex3" do
    it "should sum up an array" do
      result = Exercises.ex3 [5,6,7]
      expect(result).to eq(18)
    end
  end

  describe "ex3" do
    it "should sum up an array" do
      result = Exercises.ex3 [5,6,7]
      expect(result).to eq(18)
    end
  end

  describe "ex3" do
    it "should sum up an array" do
      result = Exercises.ex3 [5,6,7]
      expect(result).to eq(18)
    end
  end

  describe "ex3" do
    it "should sum up an array" do
      result = Exercises.ex3 [5,6,7]
      expect(result).to eq(18)
    end
  end

end
