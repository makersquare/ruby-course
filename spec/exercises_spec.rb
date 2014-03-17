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

  it "returns the number of elements in the array"do
    result=Exercises.ex1(["fighting", "yell","shout"])
    execpt(result).to eq("")
end
