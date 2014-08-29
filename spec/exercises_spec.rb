require_relative '../exercises.rb'
require 'pry-byebug'
 

describe 'Exercises' do
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
    result = Exercises.ex1([4, 5, 7, 9])
    

    expect(result).to eq(4)
  end
end

describe 'Exercise 2' do
  it "returns the second element of an array" do
    result = Exercises.ex2([4, 5, 7, 9])

    expect(result).to eq(5)
  end
end

describe 'Exercise 3' do
  it "returns the sum of the given array of numbers" do
    result = Exercises.ex3([4, 5, 7, 9])

    expect(result).to eq(25)
  end
end

describe 'Excercise 4' do
  it "returns the max number of the given array" do 
    result = Exercises.ex4([4, 5, 7, 9])

    expect(result).to eq(9)
  end
end

describe 'Excercise 5' do
  it "iterates through an array and `puts` each element" do
    array = [1, 2, 3]
    STDOUT.should_receive(:puts).with(1)
    STDOUT.should_receive(:puts).with(2)
    STDOUT.should_receive(:puts).with(3)
    Exercises.ex5(array)
  end
end

describe 'Exercise 6' do
  it "last item n array to 'panda',If the last already 'panda', update to 'GODZILLA'" do
    result1 = Exercises.ex6(["blah", "blah", "blah", "panda"])
    result2 = Exercises.ex6(["blah", "blah", "blah", "blah"])

    expect(result1).to eq(["blah", "blah", "blah", "GODZILLA"])
    expect(result2).to eq(["blah", "blah", "blah", "panda"])
  end
end
describe 'Exercise 7' do
  it "If the string exists in the array add it to the end of the array" do
    result = Exercises.ex7(["blah", "jungle", "sloppy"], "sloppy")
    result2 = Exercises.ex7(["blah", "jungle", "sloppy"], "dog")

    expect(result).to eq(["blah", "jungle", "sloppy", "sloppy"])
    expect(result2).to eq(["blah", "jungle", "sloppy"])
  end
end

describe 'Exercise 8' do
  it "Iterate through people_hash and print out their name and occupation." do
   people = [{:name => 'Bob', :occupation => 'Builder' },
             {:name => 'Tom', :occupation => 'Climber' }]

    Exercises.should_receive(:print).with("Bob the Builder")
    Exercises.should_receive(:print).with("Tom the Climber")
    Exercises.ex8(people)
  end
end

describe 'Exercise 9' do 
  it "Returns `true` if the given time is in a leap year" do 
    result = Exercises.ex9(1996)
    result2 = Exercises.ex9(2002)

    expect(result).to eq(true)
    expect(result2).to eq(false)
  end
end

describe 'Exercise 10' do
  it "check to see if the time is happy hour" do
    early = Time.parse("11 am")
    late = Time.parse("5:30 pm")

    Time.stub(:now).and_return(early)
    expect(Exercises.ex10).to eq("Normal Prices")

    Time.stub(:now).and_return(late)
    expect(Exercises.ex10).to eq("Happy Hour")
    
  end
end






