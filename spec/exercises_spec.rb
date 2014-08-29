require "./exercises.rb"
require 'pry-byebug'


describe 'Exercises' do
  it "3x original string 'abc' => 'abcabcabc', unless str='wishes', then => 'nope'" do
    expect(Exercises.ex0('abc')).to eq 'abcabcabc'
    expect(Exercises.ex0('wishes')).to eq 'nope'
  end

  it "Returns the number of elements in the array" do
    expect(Exercises.ex1([1,2,3,4,5,6,7,8,9])).to eq(9)
    expect(Exercises.ex1([])).to eq(0)
  end

  it 'Returns the second element of an array' do
    expect(Exercises.ex2([9,8])).to eq(8)
    expect(Exercises.ex2([9,8])).to eq(8)
    expect(Exercises.ex2([9])).to eq(nil)
    expect(Exercises.ex2([10,9,8,7,6,5,4,3,2,1])).to eq(9)
  end

  it 'Returns the sum of the given array of numbers' do
    expect(Exercises.ex3([9,8])).to eq(17)
    expect(Exercises.ex3([9])).to eq(9)
    expect(Exercises.ex3([10,9,8,7,6,5,4,3,2,1])).to eq(55)
  end

  it 'Returns the max number of the given array' do
    expect(Exercises.ex4([])).to eq(nil)
    expect(Exercises.ex4([9])).to eq(9)
    expect(Exercises.ex4([10,9,8,7,88,6,5,4,15,3,2,1])).to eq(88)
  end
  it 'Iterates through an array and `puts` each element' do
    STDOUT.should_receive(:puts).with("string")
    STDOUT.should_receive(:puts).with('cheese')
    Exercises.ex5(["string", 'cheese'])
  end
end