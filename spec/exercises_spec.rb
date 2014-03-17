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
  it 'returns the sum of the given array of elements' do
    arr = [1, 2, 3, 4]
    result = Exercises.ex3(arr)
    expect(result).to eq 10
  end
end

describe 'self.ex4' do
  it 'returns the max number of the given array' do
    arr = [1, 2, 3, 4]
    result = Exercises.ex4(arr)
    expect(result).to eq 4
  end
end

describe 'self.ex5' do
  it 'iterates through an array and puts each element' do
    arr = [1,2,3,4]
    expect(STDOUT).to receive(:puts).with(1)
    expect(STDOUT).to receive(:puts).with(2)
    expect(STDOUT).to receive(:puts).with(3)
    expect(STDOUT).to receive(:puts).with(4)
    Exercises.ex5(arr)
  end
end

describe 'self.ex6' do
  it 'updates the last item in the array to "panda"' do
    arr = [1, 2, 3, 4]
    str = "panda"
    Exercises.ex6(arr, str)
    result = arr[-1]
    expect(result).to eq("panda")

    arr2 = [1, 2, 3, "GODZILLA"]
    str = "GODZILLA"
    result = arr2[-1]
    Exercises.ex6(arr2, str)
    expect(result). to eq("GODZILLA")


  end
end

describe 'self.ex7' do
  it ''
end
