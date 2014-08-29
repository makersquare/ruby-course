#write the specs first. then implement your method
require './exercises.rb'
require 'rspec'

describe Exercises do
  it "exists" do 
    expect(Exercises).to be_a(Module)
  end

  describe '.ex0' do
    it "triples a given string" do

      expect(Exercises.ex0("money")).to eq("moneymoneymoney")
    end
    it "returns 'nope' if string passed is 'wishes'" do

      expect(Exercises.ex0("wishes")).to eq("nope")
    end
  end

  describe '.ex1' do
    it 'returns the number of elements in the array' do

      expect(Exercises.ex1([5,3,2])).to eq(3)
    end
  end

  describe '.ex2' do
    it 'returns the second element of an array' do

      expect(Exercises.ex2([0,3,5])).to eq(3)
    end
  end

  describe '.ex3' do
    it 'returns the sum of the given array of numbers' do

      expect(Exercises.ex3([100,300])).to eq(400)
    end
  end
  describe '.ex4' do
    it 'returns the max number of the given array' do

      expect(Exercises.ex4([3,10,99])).to eq(99)
    end
  end
  describe '.ex5' do # DON'T FORGET TO DO THIS
    xit 'iterates through an array and puts each element' do
    end
  end

  describe '.ex6' do
    it 'Updates the last item in the array to "panda"' do

      expect(Exercises.ex6(["i","love","pizza"])).to eq("panda")
    end
  end


end