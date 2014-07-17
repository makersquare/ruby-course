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
