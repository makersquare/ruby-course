
require './exercises.rb'

describe 'Exercise 0' do
  it 'Triples the given string' do

    result = Exercises.ex0("yo")

    expect(result).to eq("yoyoyo")

  end

  it 'Returns nope if the string is "wishes" ' do

    result = Exercises.ex0("wishes")
    expect(result).to eq("nope")
  end

end

describe 'Exercises 1' do
  it 'Returns # of elements in a array' do
    array = [2,4,6,8]
    result = Exercises.ex1(array)
    expect(result).to eq(4)
  end

end
