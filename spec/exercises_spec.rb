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


