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
  it 'adds str to the end of the array if str already exists' do
    arr = ['a', 'b', 'c', 'd']
    str = 'b'
    result = Exercises.ex7(arr, str)

    new_arr = ['a', 'b', 'c', 'd', 'b']
    expect(result).to eq(new_arr)
  end
end

describe 'self.ex8' do
  it 'iterates through an array of hashes and prints key and value' do
    p1 = { :name => 'Bob', :occupation => 'Builder' }
    p2 = { :name => 'Titty', :occupation => 'Tank' }
    p3 = { :name => 'Franklin', :occupation => 'Turtle' }

    ppl = [p1, p2, p3]

    expect(STDOUT).to receive(:puts).with("#{ppl[0][:name]}, #{ppl[0][:occupation]}")
    expect(STDOUT).to receive(:puts).with("#{ppl[1][:name]}, #{ppl[1][:occupation]}")
    expect(STDOUT).to receive(:puts).with("#{ppl[2][:name]}, #{ppl[2][:occupation]}")
    Exercises.ex8(ppl)

  end
end

describe 'self.ex9' do
  it 'returns true if the given time is in a leap year' do
    time = Time.new(2014, 1, 1)
    current_year = time.year
    Time.stub(:now).and_return(time)

    result = Exercises.ex9(time)

    expect(result).to eq(false)

  end
end
