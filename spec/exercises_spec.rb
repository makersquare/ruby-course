require "./exercises.rb"
require 'pry-byebug'
# require 'spec_helper'

def capture_stdout(&block)
  original_stdout = $stdout
  $stdout = fake = StringIO.new
  begin
    yield
  ensure
    $stdout = original_stdout
  end
  fake.string
end

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
  it "counts the number of elements in an array" do
    result = Exercises.ex1([1,2,3,4])
    expect(result).to eq(4)
  end
end

describe 'Exercise 2' do
  it "returns the second element of the array" do
    result = Exercises.ex2([1,2,3,4,5])
    expect(result).to eq(2)
  end
end

describe 'Exercise 3' do
  it "returns the sum of an array of numbers" do
    result = Exercises.ex3([1,2,3,4])
    expect(result).to eq(10)
  end
end

describe 'Exercise 4' do
  it "returns the maximum of an array of numbers" do
    result = Exercises.ex4([1,2,5,3,7])
    expect(result).to eq(7)
  end
end

describe 'Exercise 5' do
  it "puts all elements of the array" do
    result = capture_stdout { Exercises.ex5([1,2,3,4]) }

    result.should == "1\n2\n3\n4\n"
  end
end

describe 'Exercise 6' do
  it "updates last item of an array to be panda" do
    result = Exercises.ex6([1,2,3,4])
    expect(result).to eq([1,2,3,'panda'])
  end

  it "updates last element to be GODZILLA if last element is panda" do
    result = Exercises.ex6([1,2,3,'panda'])
    expect(result).to eq([1,2,3,'GODZILLA'])
  end

end

describe 'Exercise 7' do
  it "adds str to the end of an array if str is element of array" do
    result = Exercises.ex7([1,2,'str',3,4], 'str')
    expect(result).to eq([1,2,'str',3,4,'str'])
  end
end

describe 'Exercise 8' do
  it "given an array of hashes, prints out each hash" do
    result = capture_stdout { Exercises.ex8([{ :name => 'Bob', :occupation => 'Builder' },
     { :name => 'Dora', :occupation => 'Explora'}]) }
    result.should == "BobBuilderDoraExplora"
  end
end

describe 'Exercise 9' do
  it "tells whether the given year is a leap year (true case)" do
    result = Exercises.ex9(2000)
    expect(result).to eq(true)
  end
  it "tells whether the given year is a leap year (false case)" do
    result = Exercises.ex9(1900)
    expect(result).to eq(false)
  end
end

describe 'Exercise 10' do
  it "determines if happy hour is going on" do
    result = Exercises.ex10
    expect(result).to eq("normal prices")
  end
end

describe 'Exercise 11' do
  it "adds two numbers if they are integers" do
    result = Exercises.ex11(9, 5)
    expect(result).to eq(14)
  end

  it "should raise an error for two non-integers" do
    result = Exercises.ex11("eb", 3.7)
    expect(result).to raise(RuntimeError)
  end
end

describe 'Exercise 12' do
  it "should return an array with missing characters" do
    result = Exercises.ex12('c', 'g')
    expect(result).to eq(['c','d','e','f','g'])
  end
end
