require './exercises.rb'

describe 'Exercise 0' do
  it "triples a given string" do
    result = Exercises.ex0("damn")
    expect(result).to eq("damndamndamn")
  end

  it "returns 'nope' if string is 'wishes'" do
    result = Exercises.ex0("wishes")
    expect(result).to eq("nope")
  end

end

describe 'Exercise 1' do
  it "returns the number of elements in an array" do
    array = [1,2,3]
    expect(Exercises.ex1(array)).to eq(3)
  end
end

describe 'Exercise 2' do
  it "returns the 2nd element of an array" do
    array = [1,2,3]
    expect(Exercises.ex2(array)).to eq(2)
  end
end

describe 'Exercise 3' do
  it "returns the sum of an array" do
    array = [1,2,3]
    expect(Exercises.ex3(array)).to eq(6)
  end
end

describe 'Exercise 4' do
  it "returns the max number in a given array" do
    array = [1,2,3]
    expect(Exercises.ex4(array)).to eq(3)
  end
end





