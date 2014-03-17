require './exercises.rb'

describe 'Exercise 0' do
  it 'triples a given string' do
    #Write your test
    result = Exercises.ex0('ha')
    expect(result).to  eq 'hahaha'
  end

  it 'returns nope if string equals wishes' do
    result = Exercises.ex0('wishes')
    expect(result).to eq 'nope'
  end
end

describe 'Excercise 1' do
  it 'returns the number of elements in the array' do
    the_array = ["hey","whats","up"]
    result = Exercises.ex1(the_array)
    expect(result).to eq 3
  end
end

describe 'Excercise 2' do
  it 'returns the second element of an array' do
    the_array1 = ["hey","whats","up"]
    result = Exercises.ex2(the_array1)
    expect(result).to eq "whats"
  end
end

describe 'Excercise 3' do
  it 'returns the sum of the given array of numbers' do
    the_array1 = [1,2,3,4,5]
    result = Exercises.ex3(the_array1)
    expect(result).to eq 15
  end
end

describe 'Excercise 4' do
  it 'returns the max number of the given array' do
    the_array1 = [1,2,3,4,5]
    result = Exercises.ex4(the_array1)
    expect(result).to eq 5
  end
end

describe 'Excercise 5' do
  it 'iterates through an array and puts each element' do
    expect(STDOUT).to receive(:puts).with('hey')
    expect(STDOUT).to receive(:puts).with('whats')
    expect(STDOUT).to receive(:puts).with('up')
    the_array1 = ["hey","whats","up"]
    result = Exercises.ex5(the_array1)
  end
end

describe 'Excercise 6' do
  it 'updates last item in the array to panda' do
    the_array1 = ["hey","whats","up","man"]
    the_word = "panda"
    result = Exercises.ex6(the_array1, the_word)
    expect(result).to eq ["hey","whats","up","panda"]
  end
end

describe 'Excercise 7' do
  it 'if string exists in array, add it again to the end' do
    the_array1 = ["hey","whats","up","man"]
    the_word = "whats"
    result = Exercises.ex7(the_array1, the_word)
    expect(result).to eq ["hey","whats","up","man","whats"]
  end
end

describe 'Excercise 8' do
  it 'iterate through hash and print name and occupation' do
    expect(STDOUT).to receive(:puts).with('Bob')
    expect(STDOUT).to receive(:puts).with('Builder')
    expect(STDOUT).to receive(:puts).with('Bob2')
    expect(STDOUT).to receive(:puts).with('Builder2')
    the_array = [{:name => 'Bob', :occupation => 'Builder'}, {:name => 'Bob2', :occupation => 'Builder2'}]
    result = Exercises.ex8(the_array)
  end
end

describe 'Excercise 9' do
  it 'returns true if given time is in a leap year' do
    the_time = 2012
    the_time2 = 2014
    result = Exercises.ex9(the_time)
    result2 = Exercises.ex9(the_time2)
    expect(result).to eq true
    expect(result2).to eq false
  end
end

describe "RPS" do
  it "allows player 1 and player 2 to be added to their own array in initialize" do
    player1 = "Drew"
    player2 = "Jose"
    result = RPS.new(player1, player2)
    expect(result.player1).to eq (["Drew",0])
  end

  it "plays out the game" do
    player1 = "Drew"
    player2 = "Jose"
    result = RPS.new(player1, player2)
    player1choice = "rock"
    player2choice = "paper"
    result1 = result.play(player1choice,player2choice)
    expect(result.player2).to eq (["Jose", 1])
  end

  it "plays out the game and wins after 2 wins" do
    player1 = "Drew"
    player2 = "Jose"
    result = RPS.new(player1, player2)
    player1choice = "rock"
    player2choice = "paper"
    result1 = result.play(player1choice,player2choice)
    player1choice = "rock"
    player2choice = "paper"
    result2 = result.play(player1choice,player2choice)
    expect(result.winner).to eq ("Jose")
  end


end

