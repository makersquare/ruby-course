require 'pry-byebug'
require "./exercises.rb"

describe 'Exercise 0' do
  it 'triples the length of a string' do
    result = Exercises.ex0("ha")

    expect(result).to eq("hahaha")
  end

  it "returns 'nope' if the string is 'wishes'" do
    result = Exercises.ex0("wishes")
    expect(result).to eq("nope")
  end
end

describe 'Exercise 1' do
  it 'returns the number of elements in an array' do
    result = Exercises.ex1([1,2,3])
    
    expect(result).to eq(3)
  end
end

describe 'Exercise 2' do
  it 'returns the second element of an array' do
    result = Exercises.ex2([1,2,3])

    expect(result).to eq(2)
  end
end

describe 'Exercise 3' do
  it 'returns the sum of an array of numbers' do
    result = Exercises.ex3([1,2,3])

    expect(result).to eq(6)
  end
end

describe 'Exercise 4' do
  it 'returns the max value in an array' do
    result = Exercises.ex4([1,2,3])

    expect(result).to eq(3)
  end
end

describe 'Exercise 5' do
  it 'puts each element in an array' do

  expect(STDOUT).to receive(:puts).and_return(1)
  expect(STDOUT).to receive(:puts).and_return(2)
  expect(STDOUT).to receive(:puts).and_return(3)

  result = Exercises.ex5([1,2,3])
  end
end

describe 'Exercise 6' do
  it "updates last item in array to 'panda'" do
    result = Exercises.ex6([1,2,3])

    expect(result).to eq([1,2,3,"panda"])
  end

  it "updates last item in array to 'GODZILLA' if last item is 'panda'" do
    result = Exercises.ex6([1,2,3,"panda"])

    expect(result).to eq([1,2,3,"panda","GODZILLA"])
  end

end

describe 'Exercise 7' do
  it 'adds a given string to the end of an array if it already exists in the array' do
    result = Exercises.ex7(["hello","hi"],"hello")

    expect(result).to eq(["hello","hi","hello"])
  end
  
  it 'does not add the string if it does not exist in the array' do
    result = Exercises.ex7(["hello","hi"],"bye")

    expect(result).to eq(["hello","hi"])
  end
end

describe 'Exercise 8' do
  it 'prints values in a hash' do

    array = [
        { :name => 'Bob', :occupation => 'Builder' },
        { :name => 'Chris', :occupation => 'Blah'}
        ]
  
    expect(STDOUT).to receive(:puts).and_return("Bob Builder")
    expect(STDOUT).to receive(:puts).and_return("Chris Blah")

    result = Exercises.ex8(array)
  end
end

describe 'Exercise 9' do
  it 'returns true if the given time is a leap year' do
    result = Exercises.ex9(2000)
  
    expect(result).to eq(true)
  end

  it 'returns false if the given time is not a leap year' do
    result = Exercises.ex9(2001)

    expect(result).to eq(false)
  end
end

describe 'RPS' do

  it 'returns player 1 name if player 1 wins' do
    game1 = RPS.new("Chris", "Zach")
    game1.play("rock", "scissors")
    expect(STDOUT).to receive(:puts).and_return("Chris wins the round..")

    # expect(result).to eq("Chris wins the round..")
  end

  xit 'returns player 2 name if player 2 wins' do
    game1 = RPS.new("Chris", "Zach")
    result = game1.play("paper", "scissors")

    expect(result).to eq("Zach wins the round..")
  end

  xit 'returns tie if it is a tie' do
    game1 = RPS.new("Chris", "Zach")
    result = game1.play("paper", "paper")

    expect(result).to eq("Tie game, play again..")
  end

  xit 'ends the game if player 1 wins two games' do
    game1 = RPS.new("Chris", "Zach")
    game1.play("paper", "rock")
    game1.play("paper", "rock")

    expect(game1.play("paper", "rock")).to eq("Chris wins the game!")
  end

  xit 'ends the game if player 2 wins two games' do
    game1 = RPS.new("Chris", "Zach")
    game1.play("paper", "scissors")
    game1.play("paper", "scissors")

    expect(game1.play("paper", "scissors")).to eq("Zach wins the game!")

  end

end



