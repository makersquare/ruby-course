
require './exercises.rb'

describe 'Exercise 0' do
  it 'Triples the given string' do

    result = Exercises.ex0("yo")

    expect(result).to eq("yoyoyo")

  end

  it 'Returns nope if the string is "wishes" ' do

    result = Exercises.ex0("wishes")
    expect(result).to eq("nope")
  end

end

describe 'Exercise 1' do
  it 'Returns # of elements in a array' do
    array = [2,4,6,8]
    result = Exercises.ex1(array)
    expect(result).to eq(4)
  end

end

describe 'Exercise 2' do
  it 'Returns second element in array' do
    array = [1,23,2453,32523,325]
    result = Exercises.ex2(array)
    expect(result).to eq(23)
  end

end

describe 'Exercise 3' do
  it 'Returns the sum of an array' do
    array = [2,3,4,1]
    result = Exercises.ex3(array)
    expect(result).to eq(10)
  end
end

describe 'Exercise 4' do
  it 'Returns max number in a array' do
    array = [1,23,23423,99999,12]
    result = Exercises.ex4(array)
    expect(result).to eq(99999)
  end
end

describe 'Exercise 5' do
  it 'Iterates through an array and puts each element' do
    array = ['hey', 'whats', 'up']

    expect(STDOUT).to receive(:puts).with("hey")
    expect(STDOUT).to receive(:puts).with("whats")
    expect(STDOUT).to receive(:puts).with("up")

    result = Exercises.ex5(array)
  end
end

describe 'Exercise 6' do
  it 'updates the last item in the array to panda' do
    array = ['tiger', 'shark', 'bear']
    result = Exercises.ex6(array, 'panda')
    expect(result).to eq('panda')
  end

  it 'if the last item in the array is panda update it to GODZILLA' do
    array = ['tiger', 'shark', 'panda']
    result = Exercises.ex6(array, 'panda')
    expect(result).to eq("GODZILLA")
  end
end

describe 'Exercise 7' do
  #it ' if the string str exist in the array, add it to the end of the array' do
 #   array = ['whats','up', 'hey']
 #   result = Exercises.ex7(array, 'whats')
  #  expect(result).to eq('whats')
  #end
end

describe 'RPS' do
  describe 'initializes' do
    it 'initializes with two player names' do
      game = RPS.new('mike', 'jordan')

      expect(game.player_one[:name]).to eq('mike')
      expect(game.player_two[:name]).to eq('jordan')
    end
  end
  describe '#play' do
    it 'takes two strings representing player moves' do
      game = RPS.new('mike', 'jordan')
      game.play('rock', 'paper')
    end

    it 'return the winner' do
      game = RPS.new('mike', 'jordan')
      winner =  game.play('rock', 'paper')
      expect(winner).to eq('jordan')

      game = RPS.new('mike', 'jordan')
      winner =  game.play('rock', 'scissors')
      expect(winner).to eq('mike')

    end
  end
end


