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

  it "Returns the second element of an array" do
    array = [1,2,"hi","bye",4]
    second_element_array = Exercises.ex2(array)
    expect(second_element_array).to eq (2)
  end

  it "Returns the sum of the given array of numbers" do
    array = [4,6,10,20,5]
    total_sum = Exercises.ex3(array)
    expect(total_sum).to eq (45)
  end

  it "Returns the max number of the given array" do
    array = [1,32423,5,64235,235325,235,325,23523235,235,324,24323,23535,32]
    max_num = Exercises.ex4(array)
    expect(max_num).to eq (23523235)

  end

end
