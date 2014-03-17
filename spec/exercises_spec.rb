require "./exercises.rb"
require 'pry-debugger'

describe Exercises do

  it "Ex 0, triples a given string" do
    tripleword = Exercises.ex0("hi")
    expect(tripleword).to eq ("hihihi")

    wishes = Exercises.ex0("wishes")
    expect(wishes).to eq ("nope")
  end

  it "Ex 1, Returns the number of elements in the array" do
    array = [1,2,"hi","bye",4]
    number_elements_array = Exercises.ex1(array)
    expect(number_elements_array).to eq (5)
  end

end
