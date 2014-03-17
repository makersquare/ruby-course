require './exercises.rb'

describe 'Exercise 0' do
  it 'triples a given string' do
    #Write your test
    result = Exercises.ex0('ha')
    expect(result).to  eq 'hahaha'
  end

  it 'returns nope if string equals wishes' do
    result = Exercises.ex0('wishes')
    expect(result).to eq 'nope'
  end
end

describe 'Excercise 1' do
  it 'returns the number of elements in the array' do
    the_array = ["hey","whats","up"]
    result = Exercises.ex1(the_array)
    expect(result).to eq 3
  end
end

describe 'Excercise 2' do
  it 'returns the second element of an array' do
    the_array1 = ["hey","whats","up"]
    result = Exercises.ex2(the_array1)
    expect(result).to eq "whats"
  end
end

describe 'Excercise 3' do
  it 'returns the sum of the given array of numbers' do
    the_array1 = [1,2,3,4,5]
    result = Exercises.ex3(the_array1)
    expect(result).to eq 15
  end
end

describe 'Excercise 4' do
  it 'returns the max number of the given array' do
    the_array1 = [1,2,3,4,5]
    result = Exercises.ex4(the_array1)
    expect(result).to eq 5
  end
end

describe 'Excercise 5' do
  it 'iterates through an array and puts each element' do
    expect(STDOUT).to receive(:puts).with('hey')
    expect(STDOUT).to receive(:puts).with('whats')
    expect(STDOUT).to receive(:puts).with('up')
    the_array1 = ["hey","whats","up"]
    result = Exercises.ex5(the_array1)
  end
end

describe 'Excercise 6' do
  it 'updates last item in the array to panda' do
    the_array1 = ["hey","whats","up","man"]
    the_word = "panda"
    result = Exercises.ex6(the_array1, the_word)
    expect(result).to eq ["hey","whats","up","panda"]
  end
end

describe 'Excercise 7' do
  it 'if string exists in array, add it again to the end' do
    the_array1 = ["hey","whats","up","man"]
    the_word = "whats"
    result = Exercises.ex7(the_array1, the_word)
    expect(result).to eq ["hey","whats","up","man","whats"]
  end
end




