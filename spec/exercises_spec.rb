require 'pry-debugger'
require "./exercises.rb"
require 'time'

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

describe 'Exercise 2' do
  it 'returns the second element of an array' do
    result = [0,1,2,3]
    expect(Exercises.ex2(result)).to eq(1)
  end
end

describe 'Exercise 3' do
  it 'returns the sum of values in an array' do
    result = [0,1,2,3]
    expect(Exercises.ex3(result)).to eq(6)
  end
end

describe 'Exercise 4' do
  it 'returns the max value of an array' do
    result = [4,4,5,6]
    expect(Exercises.ex4(result)).to eq(6)
  end
end



describe 'Exercise 5' do
  it 'puts each item of an array' do
    result = ["yes","no"]
    expect(STDOUT).to receive(:puts).with("I say yes")
    expect(STDOUT).to receive(:puts).with("I say no")
    Exercises.ex5(result)
  end
end


describe 'Exercise 6' do
  it 'replaces the last item with panda' do
    result = ["yes", "no"]
    Exercises.ex6(result, 'panda')
    expect(result[-1]).to eq("panda")
  end
  it "replaces it with godzilla if has panda" do
    result = ["yes", "panda"]
     Exercises.ex6(result, 'panda')
    expect(result[-1]).to eq("GODZILLA")
  end
end

describe 'Exercise 7' do
  it "works" do
  result = ["yes", "no", "blue", "blue"]
  Exercises.ex7(result, "blue")
  expect(result).to eq(["yes", "no", "blue", "blue", "blue", "blue"])
  end
end

describe 'Exercise 8' do
  it "works" do
    result = [{name: "Parth", occupation: "Student"}, {name: "Dan", occupation: "Student"}]
    expect(STDOUT).to receive(:puts).with("Parth: Student")
    expect(STDOUT).to receive(:puts).with("Dan: Student")
    Exercises.ex8(result)
  end
end

describe 'Exercise 9' do
  it "works" do
  result = Time.now
  expect(Exercises.ex9(result)).to eq(false)
end
end


describe 'RPS' do
  it 'rock ties rock' do
    game = RPS.new("rock", "rock")
    expect(game.play).to eq("Tie")
  end
  it 'paper beats rock' do
    game = RPS.new("rock", "paper")
    # binding.pry
    expect(game.play).to eq("Congrats User 2!")
  end
  it 'scissors ties scissors' do
    game = RPS.new("scissors", "scissors")
    expect(game.play).to eq("Tie.")
  end
  it 'scissors beats paper' do
    game = RPS.new("scissors", "paper")
    expect(game.play).to eq("Congrats User 1!")
  end
end













