require './exercises.rb'

describe 'Exercise 0' do
  it "triples the length of a string" do
    result = Exercises.ex0("ha")
    result.should eq "hahaha"
  end

  it "returns 'nope' if the string is 'wishes'" do
    result = Exercises.ex0("wishes")
    result.should eq "nope"
  end

  it "only works for string objects" do
    expect {Exercises.ex0(6)}.to raise_error
  end
end

describe 'Excercise 1' do
  it "returns the correct number of elements in an array" do
    Exercises.ex1([7,4,5]).should eq 3
  end

  it "only works for array objects" do
    expect { Exercises.ex1('nope') }.to raise_error
  end
end

describe 'Exercise 2' do
  it "returns the second element of an array" do
    Exercises.ex2([1,5,3,2,6]).should eq 5
  end

  it "only works for array objects" do
    expect {Exercises.ex2('nope')}.to raise_error
  end
end

describe "Exercise 3" do
  it "adds up all the elements in an array" do
    result = Exercises.ex3([4,7,8,4,2])
    result.should eq 25
  end

  it "only works for array objects" do
    expect {Exercises.ex3('nope')}.to raise_error
  end
end

describe "Exercise 4" do
  it "returns the max number of a given array" do
    result = Exercises.ex4([4,7,3,2,7,8])
    result.should eq 8
  end

  it "should work with arrays mixed with ojbects other than numbrs" do
    result = Exercises.ex4([6,3,4,9,'obstacle'])
    result.should eq 9
  end

  it "only works for array objects" do
    expect {Exercises.ex4('test')}.to raise_error
  end
end

describe "Exercise 5" do
  it "should puts each element of the array" do

  end
end

describe "Exercise 6" do
  it "changes the last element of an array to 'panda'" do
    result = Exercises.ex6([7, 'up', 5, 4])
    result.should eq 'panda'
  end

  it "only works for array objects" do
    expect {Exercises.ex6(7)}.to raise_error
  end
end

describe "Exercise 7" do
  it "adds given string to end of given array if array includes string" do
    result = Exercises.ex7([8,5,'test',4], 'test')
    result.last.should eq 'test'
  end

  it "doesn't add given string to end of array if array doesn't include string" do
    result = Exercises.ex7([8,5,4], 'test')
    result.should eq [8,5,4]
  end
end

describe "Exercise 8" do
  xit "prints person's name and occupation" do
    result = Exercises.ex8({'Austin' => 'copywriter'})
    expect(result).to eq "Austin, copywriter"
  end

  xit "only accepts hash objects as parameter" do
    expect {Exercises.ex8(78)}.to raise_error
  end
end

describe "Exercise 9" do
  it "should return true if the year is a leap year" do
    leap_year = DateTime.new(2012,2,3)
    date = DateTime.stub(:now).and_return(leap_year)
    expect(Exercises.ex9(date)).to be_true
  end

  it "should return false if the year is not a leap year" do
    not_leap_year = DateTime.new(2014, 2, 3)
    date = DateTime.stub(:now).and_return(not_leap_year)
    expect(Exercises.ex9(date)).to be_false
  end
end

describe RPS do
  before do
    @rps = RPS.new(player1: 'player1', player2: 'player2')
  end

  it "initializes with the names of two players" do
    @rps.player1.should eq 'player1'
    @rps.player2.should eq 'player2'
  end

  it "initializes with an empty winner array" do
    @rps.winner_array.should eq []
  end

  it "returns the name of the winner after a single round" do
    @rps.play('rock', 'paper').should eq 'player2'
    @rps.play('scissors', 'paper').should eq 'player1'
  end

  it "returns the ultimate winner after 3 rounds" do
    @rps.play('rock', 'paper')
    @rps.play('paper', 'rock')
    @rps.play('rock', 'paper').should eq "player2"
  end

  it "resets the winner_array after complete round" do
    2.times {@rps.play('rock', 'paper')}
    expect(@rps.winner_array).to eq []
  end

  it "returns 'tie' in event of tie" do
    @rps.play('rock', 'rock').should eq 'tie'
  end

  it "plays more than three rounds if ties are involved" do
    @rps.play('rock', 'rock')
    @rps.play('paper', 'paper')
    @rps.play('rock', 'paper')
    @rps.play('scissors', 'paper')
    @rps.winner_array.should eq ['tie', 'tie', 'player2', 'player1']
  end

  it 'ignores ties in final winner count' do
    4.times {@rps.play('rock', 'rock')}
    @rps.play('paper', 'scissors')
    @rps.play('paper', 'scissors').should eq 'player2'
  end

  it "outputs the winner of each round" do
    expect(STDOUT).to receive(:puts).and_return("player1 wins this round")
    @rps.play('rock', 'scissors')
  end
end
