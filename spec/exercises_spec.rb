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
  it "finds the number of elements in an array" do
    array = %w(big, dog, jogs, all, day)
    result = Exercises.ex1(array)
    expect(result).to eq(5)    
  end  
end
