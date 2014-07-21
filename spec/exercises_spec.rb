require './exercises.rb'

describe 'Exercise 0' do

  before do
    @result = [1, 2, "win", "James", 8]
  end

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

describe 'Exercise 2' do
  
  it "returns the second element of an array" do
    result = Exercises.ex2([1, "block", 3, 4.9, "win"])
    expect(result).to eq('block')
  end
end

describe 'Exercise 3' do

  it "returns the sum of the given array of numbers" do 
    result = Exercises.ex3([1, 2, 3, 4, 5])
    expect(result).to eq(15)
  end
end

describe 'Exercise 4' do

  it "returns the max number of the given array" do
    result = Exercises.ex4([1, 2, 3, 42, 75, 23])
    expect(result).to eq(75)
  end
end

describe 'Exercise 5' do

  it "Iterates through an array and 'puts' each element" do
    result = Exercises.ex5([1, 2, 3])
    expect(STDOUT).to receive(:puts).with(1)
    expect(STDOUT).to receive(:puts).with(2)
    expect(STDOUT).to receive(:puts).with(3)
    Exercises.ex5(result)
  end
end

describe 'Exercise 6' do

  it "Updates the last item in the array to 'panda'." do
    array = ["joe", "rabbit", "mikey", 'bike']
    result = Exercises.ex6(array)
    expect(result[-1]).to eq('panda')
  end
  
  it "Updates the last item in the array to 'GODZILLA'." do
    array = ["joe", "rabbit", "mikey", 'bike']
    result = Exercises.ex6(array)
    expect(result[-1]).to eq('panda')
    result = Exercises.ex6(array)
    expect(result[-1]).to eq('GODZILLA')
  end
end

describe 'Exercise 7' do
  
  it "Adds a string 'word' to the end of the array if it exists in the array" do
    array = ["joe", "rabbit", "mikey", 'bike']
    string = "word"
    result = Exercises.ex7(["joe", "rabbit", "mikey", 'bike'], "word")
    expect(result).to eq(["joe", "rabbit", "mikey", "bike"])
    # expect(@result).to eq()
  end
end

describe 'Exercise 8' do

  it "Iterates through the people and prints out their name and occupation" do
    people = Exercises.ex8([{:name=>"Bob", :occupation=>"Builder"}])
    expect(people).to eq("Bob is a Builder")
  end
end
























































