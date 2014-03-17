require 'pry-debugger'
require "./exercises.rb"

describe 'Exercise 0' do
  it "triples the length of a string" do
    result = Exercises.ex0("ha")
    expect(result).to eq("hahaha")
  end

  it "returns 'nope' if the string is 'wishes'" do
    result = Exercises.ex0("wishes")
    expect(result).to eq("nope")
  end
end

describe 'Exercise 1' do
  it 'returns the # of items in an array' do
    result = [1, 2, 3, 4]
    expect(Exercises.ex1(result)).to eq(4)
  end

end
