# require 'rubygems'
require 'rspec'
# require 'pry-byebug'
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
  it "checks the length of an empty array" do
    result = Exercises.ex1([])
    expect(result).to eq(0)
  end

  it "checks the length of a single-element array" do
    result = Exercises.ex1([1])
    expect(result).to eq(1)
  end

  it "checks the length of a multiple-element array" do
    result = Exercises.ex1([1,2,3,4])
    expect(result).to eq(4)
  end

  it "checks the length of an array with variable elements" do
    array = [1, "b", :c, {}, []]
    result = Exercises.ex1(array)
    expect(result).to eq(5)
  end
end

describe 'Exercise 2' do
  it "returns the second element of an array" do
    array = [1, 2, 3]
    result = Exercises.ex2(array)
    expect(result).to eq(2)
  end

  it "returns nil if there's no second element of an array" do
    result = Exercises.ex2([])
    expect(result).to be_nil
  end
end

describe 'Exercise 3' do
  it "returns the sum of the given array of numbers" do
    array = [1,2,3,4,5]
    result = Exercises.ex3(array)
    expect(result).to eq(15)
  end

  it "returns the sum of the given array of any numbers" do
    array = [1,2,3,4,-5]
    result = Exercises.ex3(array)
    expect(result).to eq(5)
  end
end

describe 'Exercise 4' do
  it "Returns the max number of the given array" do
    array = [1,2,3,4,-5]
    result = Exercises.ex4(array)
    expect(result).to eq(4)
  end

  it "Returns nil for an empty array" do
    result = Exercises.ex4([])
    expect(result).to be_nil
  end
end

describe 'Exercise 5' do
  before do
    $stdout = StringIO.new
  end
  it "Iterates through an array of one and `puts` each element" do
    array = [1]
    $stdout.should_receive(:puts).with(1)
    Exercises.ex5(array)
  end

  it "Iterates through an array and `puts` each element" do
    array = [1,2]
    $stdout.should_receive(:puts).with(1)
    $stdout.should_receive(:puts).with(2)
    Exercises.ex5(array)
  end

  it "Iterates through an array of 3 and `puts` each element" do
    array = [1,2,3]
    $stdout.should_receive(:puts).with(1)
    $stdout.should_receive(:puts).with(2)
    $stdout.should_receive(:puts).with(3)
    Exercises.ex5(array)
  end

end

describe 'Exercise 6' do
  it "Updates the last item in the array to 'panda'" do
    array = [1,2,3]
    Exercises.ex6(array)
    expect(array).to eq([1,2,'panda'])
  end

  it "Updates the last item in the array to 'GOZILLA' if already 'panda'" do
    array = [1,2,'panda']
    Exercises.ex6(array)
    expect(array).to eq([1,2,'GODZILLA'])
  end

  it "adds 'panda' if the array is empty" do
    array = []
    Exercises.ex6(array)
    expect(array).to eq(['panda'])
  end  
end

describe 'Exercise 7' do
  it "Adds str to the end of the array if array has str" do
    array = [1,2,'panda']
    str = 'panda'
    Exercises.ex7(array,str)
    expect(array).to eq([1,2,'panda','panda'])
  end

  it "Doesn't add str to the end of the array if array has no str" do
    array = [1,2,'panda']
    str = 'GODZILLA'
    Exercises.ex7(array,str)
    expect(array).to eq([1,2,'panda'])
  end
end

describe 'Exercise 8' do
  it "Prints out a hash of people and occupations" do
    array = [
      {:name => 'Bob', :occupation => 'Builder'},
      {:name => 'Job', :occupation => 'Thinker'},
      {:name => 'Rob', :occupation => 'Thief'}
    ]
    $stdout.should_receive(:puts).with("Bob is a Builder")
    $stdout.should_receive(:puts).with("Job is a Thinker")
    $stdout.should_receive(:puts).with("Rob is a Thief")
    Exercises.ex8(array)
  end
end

 describe 'Exercise 9' do
   it "Returns `true` if the given time is in a leap year, false if not" do
     test = Exercises.ex9(2014)
     test2 = Exercises.ex9(2012)
     test3 = Exercises.ex9(2000)
     expect(test).to be_false
     expect(test2).to be_true
     expect(test3).to be_false
   end
 end

describe 'Exercise 10' do
  it "Returns 'happy hour' if within 4-6pm" do
    $stdout.should_receive(:puts).with("happy hour")
    Exercises.ex10(Time.new(2000, 10, 31, 16, 2, 2))
  end

  it "Returns 'normal prices' if outside that time" do
    $stdout.should_receive(:puts).with("normal prices")
    Exercises.ex10(Time.new(2000))
  end
end