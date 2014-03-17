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
