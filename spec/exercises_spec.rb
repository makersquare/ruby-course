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

  it "returns the sub of the given array of numbers" do
    result = Exercises.ex3([1,2,3])
    expect(result).to eq(6)
  end

  it "returns the max number of given array" do
    result = Exercises.ex4([1,5,2,9,3])
    expect(result).to eq(9)
  end

  it "iterates through an array and puts each element" do
    expect(STDOUT).to receive(:puts).with("hello")
    expect(STDOUT).to receive(:puts).with("hi")
    expect(STDOUT).to receive(:puts).with("howdy")
    Exercises.ex5(["hello", "hi", "howdy"])
  end

  it "updates the last item in the array to 'panda'" do
    result = Exercises.ex6(["donkey", "rat"], "panda")
    expect(result).to eq(["donkey", "rat", "panda"])
  end

  it "updates last item of array to 'GDOZILLA' if last item is already 'panda'" do
    result = Exercises.ex6(["donkey", "rat", "panda"], "panda")
    expect(result).to eq(["donkey", "rat", "panda", "GODZILLA"])
  end

  it "checks if 'str' is includeded in an array and if so puts it at the end of the array" do
    result = Exercises.ex7(["John","Braden","Bryan"], "John")
    expect(result).to eq(["Braden", "Bryan", "John"])
  end

  it "iterates through array of hashes and prints name and ocupation" do
    expect(STDOUT).to receive(:puts).with("Bob")
    expect(STDOUT).to receive(:puts).with("Builder")
    expect(STDOUT).to receive(:puts).with("Sponge Bob")
    expect(STDOUT).to receive(:puts).with("Burger Chef")
    Exercises.ex8([{name: "Bob", ocupation: "Builder"}, {name: "Sponge Bob", ocupation: "Burger Chef"}])
  end

  it "returns true if the given time is in a leap year" do
    result = Exercises.ex9("February 1988")
    expect(result).to eq(true)
  end

  it "returns false if the given time is NOT in a leap year" do
    result = Exercises.ex9("March 14th 1900")
    expect(result).to eq(false)
  end
end

describe RPS do
  before do
    @game = RPS.new("a", "b")
  end

  it "is initialized with two strings(player names)" do
    expect(@game.p1name).to eq("a")
    expect(@game.p2name).to eq("b")
  end

  it "has a play method that takes 2 strings" do
    expect { @game.play("rock", "scissors")}.to_not raise_error
  end

  it "returns a winner each time play method is called" do
    result=@game.play("paper", "rock")
    expect(result).to eq("player1")
    result2=@game.play("scissors", "rock")
    expect(result2).to eq("player2")
    result3=@game.play("rock","rock")
    expect(result3).to eq("tie")
  end

end



