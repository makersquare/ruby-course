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

end