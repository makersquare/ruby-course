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

# describe 'Exercise 8' do
#   it "given an array of hashes, prints out each hash" do
#     result = Exercises.ex8([{ :name => 'Bob', :occupation => 'Builder' },
#      { :name => 'Dora', :occupation => 'Explora'}])
#     expect(result).to eq('BobBuilderDoraExplora')
#   end
# end