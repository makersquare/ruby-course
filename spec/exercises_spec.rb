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

describe 'Exercise 2' do
  it "returns the second item in an array" do
    array = %w(wow there is a big dragon)
    result = Exercises.ex2(array)
    expect(result).to eq("there")
  end  
end
  
describe 'Exercise 3' do
  it "returns the sum of all the numbers in an array" do
    array = (1..5).to_a
    result = Exercises.ex3(array)
    expect(result).to eq(15)
  end
end

describe 'Exercise 4' do
  it "returns the largest number in the array" do
    array = [1, 100, 4, 3.5, 99, 47.1]
    result = Exercises.ex4(array)
    expect(result).to eq(100)
  end
end

describe 'Exercise 5' do
  it "puts each element of an array on it's own line" do
    array = [1, 2, 3]
    STDOUT.should_receive(:puts).with(1)
    STDOUT.should_receive(:puts).with(2)
    STDOUT.should_receive(:puts).with(3)
    result = Exercises.ex5(array)
  end
end

describe 'Exercise 6' do
  it "changes the last item of the array to 'panda'" do
    array = %w(big brown bear)
    result = Exercises.ex6(array)
    expect(result).to eq(["big", "brown", "panda"])
  end

  it "changes the last item to 'GODZILLA' if it's 'panda'" do
    array = %w(big brown panda)
    result = Exercises.ex6(array)
    expect(result).to eq(["big", "brown", "GODZILLA"])
  end
end

describe 'Exercise 7' do
  it "adds string to the end of array if preexisting" do
    array = [1, 2, "blue", "red", 5]
    str = "blue"
    result = Exercises.ex7(array, str)
    expect(result).to eq([1, 2, "blue", "red", 5, "blue"])
  end

  it "leaves array unchanged if sting not present" do
    array = [1, 2, "blue", "red", 5]
    str = "purple"
    result = Exercises.ex7(array, str)
    expect(result).to eq([1, 2, "blue", "red", 5])
  end
end