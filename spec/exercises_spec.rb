require 'pry-byebug'
require "./exercises.rb"


describe Exercises do

  before(:each) do
    @arr = [1,2,3]
  end

  #ex0 tests
  it 'triples a given string' do
    Exercises.ex0('blah').should eq('blahblahblah')
  end

  it 'returns nope if the string is wishes' do
    Exercises.ex0('wishes').should eq('nope')
  end

  #ex1 tests
  it 'returns the number of elements in an array' do
    Exercises.ex1(@arr).should eq(3)
  end

  #ex2 tests
  it 'returns the second element of an array' do
    Exercises.ex2(@arr).should eq(2)
  end

  #ex3 tests
  it 'returns the sum of the given array of numbers' do
    Exercises.ex3(@arr).should eq(6)
  end

  #ex4 tests
  it 'returns the max number in a given array' do
    Exercises.ex4(@arr).should eq(3)
  end

  #ex5 tests
  it 'iterates through an array and puts each item' do
    expect(STDOUT).to receive(:puts).and_return("1")
    expect(STDOUT).to receive(:puts).and_return("2")
    expect(STDOUT).to receive(:puts).and_return("3")
    Exercises.ex5(@arr)
  end

  #ex6 tests
  it "should change the last item to 'panda'" do
    Exercises.ex6(@arr).should eq('panda')
  end

  it "should change the last item to GODZILLA if the last item is already panda" do
    arg = [Exercises.ex6(@arr)]
    Exercises.ex6(arg).should eq('GODZILLA')
  end

  #ex7 tests
  it "should add str to the end of the array if a given str is in the array" do
    Exercises.ex7(@arr, 3).should eq([1,2,3,'str'])
  end

  #ex8 tests
  it "should print out the name and occupation of each person" do
    people = [ { :name => 'Bob', :occupation => 'Builder' },  { :name => 'Dora', :occupation => 'Explorer' }]
    
    expect(STDOUT).to receive(:puts).and_return("Bob")
    expect(STDOUT).to receive(:puts).and_return("Builder")
    expect(STDOUT).to receive(:puts).and_return("Dora")
    expect(STDOUT).to receive(:puts).and_return("Explorer")
    Exercises.ex8(people)
  end

  #ex9 tests
  it "should return true if the given year is a leap year" do
    Exercises.ex9(2400).should be_true
  end

  it "should return false if the given year is not a leap year" do
    Exercises.ex9(2401).should be_false
  end

end