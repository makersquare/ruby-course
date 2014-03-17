require './exercises.rb'


describe 'self.ex0' do
  it 'Triples a given string str' do
    result = Exercises.ex0('ha')
    expect(result).to eq 'hahaha'
  end

  it 'returns nope if str is wishes' do
    result = Exercises.ex0('wishes')
    expect(result). to eq 'nope'
  end
end

describe 'self.ex1' do
  it 'Returns the number of elements in the array' do
      arr = [1, 2, 3, 4]
      result = Exercises.ex1(arr)
      expect(result).to eq 4

  end
end

describe 'self.ex2' do
  it 'returns the second element of an array' do
    arr = [1, 2, 3, 4]
    result = Exercises.ex2(arr)
    expect(result).to eq 2
  end
end

describe 'self.ex3' do
  it '' do

  end
end
