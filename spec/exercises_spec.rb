require 'pry-debugger'
require "./exercises.rb"

describe Exercises do
  it 'triples a given string' do
    result = Exercises.ex0('ha')
    expect(result).to eq 'hahaha'
  end

  it 'returns "nope" if string is "wishes"' do
    result = Exercises.ex0('wishes')
    expect(result).to eq 'nope'
  end

  it 'returns the number of elements in the array' do
    result = Exercises.ex1([1,2,3])
    result2 = Exercises.ex1(['a','b','c','d','e'])
    expect(result).to eq 3
    expect(result2).to eq 5
  end

  it 'returns the second element of an array' do
    result = Exercises.ex2([1,2,3])
    result2 = Exercises.ex2(['a','b','c','d','e'])
    expect(result).to eq 2
    expect(result2).to eq 'b'
  end

  it 'returns the sum of an array of numbers' do
    result = Exercises.ex3([1,2,3])
    result2 = Exercises.ex3([10,10,10])
    expect(result).to eq 6
    expect(result2).to eq 30
  end

  it 'returns the max number of the given array' do
    result = Exercises.ex4([1,2,3])
    result2 = Exercises.ex4([10,9,8])
    expect(result).to eq 3
    expect(result2).to eq 10
  end

  it 'iterates through an array and puts each element' do
        expect(STDOUT).to receive(:puts).with("brandon")
        expect(STDOUT).to receive(:puts).with("beasley")
        Exercises.ex5(["brandon", "beasley"])
  end

  it 'updates the last item in the array to panda' do
    result = Exercises.ex6([1,2,3])
    expect(result).to eq [1,2,"panda"]
  end

  it 'puts GODZILLA instead of panda if panda is already last item' do
    result = Exercises.ex6([1,2,"panda"])
    expect(result).to eq [1,2,"GODZILLA"]
  end

  it "if str is in array add it to end of array" do
    result = Exercises.ex7(['im', 'a', 'millionaire', 'a young', 'money'], 'millionaire')
    result2 = Exercises.ex7(['brandon', 'beasley'], 'millionaire')
    expect(result).to eq ['im', 'a', 'millionaire', 'a young', 'money', 'millionaire']
    expect(result2).to eq ['brandon', 'beasley']
  end

  it "prints name and occupation of everyone in hash" do
    expect(STDOUT).to receive(:puts).with('brandon')
    expect(STDOUT).to receive(:puts).with('programmer')
    expect(STDOUT).to receive(:puts).with('aaron')
    expect(STDOUT).to receive(:puts).with('translator')
    Exercises.ex8([{ :name => 'brandon', :occupation => 'programmer'}, { :name => 'aaron', :occupation => 'translator'}])
  end

  it 'returns true if current time is leap year' do
    result = Exercises.ex9(2000)
    result2 = Exercises.ex9(2012)
    result3 = Exercises.ex9(1900)
    result4 = Exercises.ex9(2014)
    expect(result).to eq true
    expect(result2).to eq true
    expect(result3).to eq false
    expect(result4).to eq false

  end

end


describe RPS do
  before do
    @game = RPS.new('brandon', 'brady')
  end

  it "is initalized with two strings" do
    expect(@game.player1).to eq 'brandon'
    expect(@game.player2).to eq 'brady'
  end

  it "has a play method that takes two strings" do
    expect {@game.play('rock', 'scissors')}.to_not raise_error
  end

  it "returns the winner of the game" do
    result1 = @game.play('rock', 'scissors')
    expect(result1).to eq 'brandon'

    result2 = @game.play('Scissors', 'rock')
    expect(result2).to eq 'brady'

    result3 = @game.play('rock', 'rock')
    expect(result3).to eq 'tie: try again'

    result4 = @game.play('rock', 'knife')
    expect(result4).to eq 'error: not a valid weapon. try again.'
  end

end
