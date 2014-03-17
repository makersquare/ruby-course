require "pry-debugger"
require "./exercises.rb"

describe Exercises do
  it "triples a given string" do
    result = Exercises.ex0("brady")
    expect(result).to eq("bradybradybrady")
  end

  it "returns 'nope' if string == wishes" do
    result = Exercises.ex0("wishes")
    expect(result).to eq("nope")
  end

  it "returns the number of elements in an array" do
    result = Exercises.ex1([1,2,3])
    expect(result).to eq(3)
  end

  it "returns the second element of an array" do
    result = Exercises.ex2(["Brady", "Bryan"])
    expect(result).to eq("Bryan")
  end

end

