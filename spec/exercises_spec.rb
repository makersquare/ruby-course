require "./exercises.rb"

describe "Exercises" do

  it "can return triples of a given string" do
    result=Exercises.ex0("ha")
    expect(result).to eq("hahaha")
  end

  it "returns 'nope' if the stirng is 'wishes'" do
    result=Exercises.ex0("wishes")
    expect(result).to eq("nope")
  end

  it "returns the number of elements in the array" do
    result=Exercises.ex1(["fighting", "yell","shout"])
    expect(result).to eq(3)
  end

  it "returns the second element of the array" do
    result=Exercises.ex2(["fighting","yell","shout"])
    expect(result).to eq("yell")
  end

  it "returns the sum of the given array of numbers" do
    result=Exercises.ex3([1,2,3])
    expect(result).to eq(6)
  end

  it "returns the max number of the given array" do
    result=Exercises.ex4([1,2,3])
    expect(result).to eq(3)
  end

  it "iterates through array and 'puts' each element" do
    STDOUT.should_receive(:puts).with("hello")
    STDOUT.should_receive(:puts).with("morning")
    STDOUT.should_receive(:puts).with("glory")
    result=Exercises.ex5(["hello","morning","glory"])



  end


end

