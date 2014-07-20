require 'pry-byebug'
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
  it "Returns the number of elements in the array" do
    result = Exercises.ex1([1,2,3,4,5])
    expect(result).to eq(5)
  end
end

describe 'Exercise 2' do
  it "Returns the second element of an array" do
    result = Exercises.ex2([1,2,3,4,5])
    expect(result).to eq(2)
  end
end

describe 'Exercise 3' do
  it "Returns the sum of the given array of numbers" do
    result = Exercises.ex3([1,2,3,4,5])
    expect(result).to eq(15)
  end
end

describe 'Exercise 4' do
  it "Returns the max number of the given array" do
    result = Exercises.ex4([1,2,3,4,5])
    expect(result).to eq(5)
  end
end

describe 'Exercise 5' do
  it "Iterates through an array and `puts` each element" do
    $stdout = StringIO.new
    result = Exercises.ex5([1,2,3,4,5])
    $stdout.string.should == "1\n2\n3\n4\n5\n"

    # result = Exercises.ex5([1,2,3,4,5])
    # expect(STDOUT).to receive(:puts).and_return(result)
    # TestingPuts.do_it(result)


    #The real way to do it =>
    # val1 ='string'
    # expect(STDOUT).to receive(:puts).and_return(val1)
    # TestingPuts.do_it(val1)

  end
end

describe 'Exercise 6' do
  it "Updates the last item in the array to 'panda'" do
    result = Exercises.ex6([1,2,3,4,5])
    expect(result[-1]).to eq('panda')
  end

  it "If the last item is already 'panda', update it to 'GODZILLA' instead" do
    result = Exercises.ex6([1,2,3,4,'panda'])
    expect(result[-1]).to eq('GODZILLA')
  end
end

describe 'Exercise 7' do
  it "If the string `str` exists in the array,\n  add `str` to the end of the array" do
    result = Exercises.ex7([1,2,'WHARRGARBL',4,5], 'WHARRGARBL')
    expect(result).to eq([1,2,'WHARRGARBL',4,5,'WHARRGARBL'])
  end
end

describe 'Exercise 8' do
  it "Iterate through `people` and print out their name and occupation." do
    $stdout = StringIO.new
    result = Exercises.ex8([{ :name => 'Bob', :occupation => 'Builder' }, {name: 'Philip J. Fry', occupation: 'delivery boy'}])
    $stdout.string.should == "Bob\nBuilder\nPhilip J. Fry\ndelivery boy\n"
  end
end

describe 'Exercise 9' do
  it "Returns `true` if the given time is in a leap year" do
    result = Exercises.ex9(2008)
    expect(result).to eq(true)
    result = Exercises.ex9(2000)
    expect(result).to eq(true)
  end

  it "Otherwise, returns `false`" do
    result = Exercises.ex9(2014)
    expect(result).to eq(false)
    result = Exercises.ex9(1800)
    expect(result).to eq(false)
  end
end

describe 'Rock, Paper, Sissors' do

  it "each player initializes with a name" do
    new_game = RPS.new('Fry', 'Leela')
    expect(new_game.player1).to eq("Fry")
    expect(new_game.player2).to eq("Leela")
  end

  it "ensure that 'rock', 'paper', and 'sissors' are the only valid choices" do
    new_game = RPS.new('Fry', 'Leela')
    expect {new_game.play('rock', 'shotgun')}.to raise_error
    expect {new_game.play('paper', 'sissors')}.to_not raise_error
  end

  it "check for a tie" do
    new_game = RPS.new('Fry', 'Leela')
    expect {new_game.play('rock', 'rock')}.to raise_error
  end

  it "ensure that the winner of 2 out of 3 games is returned" do
    new_game = RPS.new('Fry', 'Leela')
    new_game.play('paper', 'sissors')
    winner = new_game.play('rock', 'paper')
    expect(winner).to eq('Leela')
  end

  it "ensure that 3 games can be played if needed" do
    new_game = RPS.new('Fry', 'Leela')
    new_game.play('paper', 'sissors')
    new_game.play('sissors', 'paper')
    winner = new_game.play('rock', 'paper')
    expect(winner).to eq('Leela')
  end

  it "ensure that, once the game is won, new rounds cannot be played" do
    new_game = RPS.new('Fry', 'Leela')
    new_game.play('paper', 'sissors')
    new_game.play('rock', 'paper')
    expect {new_game.play('paper', 'sissors')}.to raise_error
  end

end