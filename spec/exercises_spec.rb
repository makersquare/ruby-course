require_relative '../exercises.rb'

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
  it "returns the number of elements in the array" do
    array = [1,2,4,5]
    result = Exercises.ex1(array)
    expect(result).to eq(4)
  end
end

describe 'Exercise 2' do
  it "returns the second element of the array" do
    array = [1,2,4,5]
    result = Exercises.ex2(array)
    expect(result).to eq(2)
  end
end

describe 'Exercise 3' do
  it "Returns the sum of the given array of numbers" do
    array = [1,2,4,5]
    result = Exercises.ex3(array)
    expect(result).to eq(12)
  end
end

describe 'Exercise 4' do
  it "Returns the max number of the given array" do
    array = [1,2,4,5]
    result = Exercises.ex4(array)
    expect(result).to eq(5)
  end
end

describe 'Exercise 5' do
  it "Iterates through an array and `puts` each element" do
    array = [1,2,4,5]
    expect(STDOUT).to receive(:puts).with(1)
    expect(STDOUT).to receive(:puts).with(2)
    expect(STDOUT).to receive(:puts).with(4)
    expect(STDOUT).to receive(:puts).with(5)
    Exercises.ex5(array)
  end
end

describe 'Exercise 6' do
  it "Updates the last item in the array to 'panda'" do
    array = ["dog", "cat", "fish", "lion"]
    Exercises.ex6(array, "")
    result = array.last
    expect(result).to eq('panda')
  end

  it "If the last item is already 'panda', update   it to 'GODZILLA' instead" do
    array = ["dog", "cat", "fish", "panda"]
    Exercises.ex6(array,"")
    result = array.last
    expect(result).to eq('GODZILLA')
  end
end

describe 'Exercise 7' do
  it "inserts a string that is not already there" do
    array = ["dog", "cat", "fish", "lion"]
    Exercises.ex7(array, "horse")
    expected = ["dog", "cat", "fish", "lion", "horse"]
    expect(array).to eq(expected)
  end
end

describe 'Exercise 8' do
  it "Iterates through `people` and prints out their name and occupation" do
    array = [{ :name => 'Devon', :occupation => 'Student'},  { :name => 'Jenny', :occupation => 'Event planner'}, { :name =>'Selina',  :occupation => 'Dentist'}]

    expect(STDOUT).to receive(:puts).with("Devon: Student")
    expect(STDOUT).to receive(:puts).with("Jenny: Event planner")
    expect(STDOUT).to receive(:puts).with("Selina: Dentist")
    Exercises.ex8(array)
  end
end

describe 'Exercise 9' do
  it "Returns `true` if the given time is in a leap year" do
    Time.stub(:now).and_return(Time.new(2004))
    expect(Exercises.ex9(Time.now)).to eq(true)
  end

  it "returns false if given time is not a leap year" do
     Time.stub(:now).and_return(Time.new(2014))
      expect(Exercises.ex9(Time.now)).to eq(false)
    end
  end


describe 'RPS' do
    it "it is initialized with two strings (player names)" do
      game = RPS.new("bob", "jim")
    end

describe "play method" do

  before do
    @game = RPS.new("bob", "jim")
  end

  it "takes two strings" do
    @game.play("rock", "paper")
  end

  it "Returns 'Game over!' after someone wins 2 games" do
 name1 = @game.play("rock","rock")
      name2 = @game.play("rock","paper")
      name3 = @game.play("rock","scissors")
      name4 = @game.play("paper","rock")
      name5 = @game.play("paper","paper")

      expect(name5).to eq("Game over!")
    end
  end
end












