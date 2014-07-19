require './exercises.rb'

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

  it "returns the number of elements in the array" do
    result = Exercises.ex1([1, 2, "cats", 5.1])
    expect(result).to eq 4
  end

end