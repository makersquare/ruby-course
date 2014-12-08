# require 'rubygems'
require 'rspec'
 require 'pry-byebug'
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
    Exercises.should_receive(:print).with("Bob is a Builder")
    Exercises.should_receive(:print).with("Job is a Thinker")
    Exercises.should_receive(:print).with("Rob is a Thief")
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
    expect(test3).to be_true
   end
 end

describe 'Exercise 10' do
  it "Returns 'happy hour' if within 4-6pm" do
    happy = Time.parse("5 pm")
    Time.stub(:now).and_return(happy)
    expect(Exercises.ex10).to eq('happy hour')
  end

  it "Returns 'normal prices' if outside that time" do
    early = Time.parse("11 am")
    Time.stub(:now).and_return(early)
    expect(Exercises.ex10).to eq('normal prices')
  end
end

describe 'Extension' do
  it "Takes an array of strings and returns a hash with two keys" do
    result = Extensions.extremes(['x', 'x', 'y', 'z'])
    expect(result.keys).to eq([:most,:least])
  end

  it ":most => the string(s) that occurs the most as its value" do
    result = Extensions.extremes(['x', 'x', 'y', 'z'])
    expect(result[:most]).to eq('x')
  end

  it ":least => the string(s) that occurs the least as its value" do
    result = Extensions.extremes(['x','x','x','y','y','z'])
    expect(result[:least]).to eq('z')
  end

  it "handles ties with an array" do
    result_hi = Extensions.extremes(['x','x','y','y','z'])
    result_lo = Extensions.extremes(['x', 'x', 'y', 'z'])
    expect(result_hi).to eq({ :most => ['x','y'], :least => 'z' })
    expect(result_lo).to eq({ :most => 'x', :least => ['y', 'z'] })
  end
end
