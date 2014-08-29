require "./exercises.rb"
require 'pry-byebug'

describe 'Exercises' do

  describe '.ex0' do

    it 'should return three * the input string' do
      expect(Exercises.ex0("poo")).to eq ("poopoopoo")
    end

    it 'should return "nope" if the input string is "wishes"' do
      expect(Exercises.ex0("wishes")).to eq ("nope")
    end

  end

  describe '.ex1' do

    it 'returns the number of elements in the array' do
      expect(Exercises.ex1([1,2,3])).to eq(3)
    end

  end

  describe '.ex2' do

    it 'returns the second element of an array' do
      expect(Exercises.ex2([1,2,3])).to eq(2)
    end

  end

  describe '.ex3' do

    it 'returns the sum of the given array of numbers' do
      expect(Exercises.ex3([1,2,3])).to eq(6)
    end

  end

  describe '.ex4' do

    it 'returns the max number of the array' do
      expect(Exercises.ex4([1,2,3])).to eq(3)
    end

  end

  describe '.ex5' do

    it 'puts each element' do
      
      STDOUT.should_receive(:puts).with(1)
      STDOUT.should_receive(:puts).with(2)
      STDOUT.should_receive(:puts).with(3)
      
      Exercises.ex5([1,2,3])

    end

  end

  describe '.ex6' do

    it 'updates last array item to panda if it was not panda already' do
      expect(Exercises.ex6([1,2,3])).to eq ([1,2,'panda'])
    end

    it 'updates last array item to godzilla if it was already panda' do
      expect(Exercises.ex6([1,2,'panda'])).to eq ([1,2,'GODZILLA'])
    end

  end

  describe '.ex7' do

    it 'adds the string to the array if it already exists in the array' do
      expect(Exercises.ex7(['ya', 'big', 'dingus'], 'dingus')).to eq (['ya', 'big', 'dingus', 'dingus'])
    end

  end

  describe '.ex8' do

    it 'prints out person name and occupation' do

      people =[{name: "Billy", occupation: "garbage man"},{name: "Jimmy", occupation: "lumberjack"}]
      STDOUT.should_receive(:puts).with("Billy garbage man")
      STDOUT.should_receive(:puts).with("Jimmy lumberjack")

      Exercises.ex8(people)
    end

  end

  describe '.ex9' do
    # 2008, 2012, 2016, ...
    it 'returns true if the given time is in a leap year' do 
      expect(Exercises.ex9(Time.new(2016))).to eq(true)
    end

    it 'returns false if the given time is not in a leap year' do
      expect(Exercises.ex9(Time.new(2009))).to eq(false)
    end

  end

  describe '.ex10' do

    it 'returns happy hour if it is between 4pm and 6pm' do
      #4:30:30
      time1 = Time.new(2014, 8, 29, 13, 30, 30) 
      expect(Exercises.ex10(time1)).to eq("happy hour")
    end

    it 'returns normal prices if it is not between 4pm and 6pm' do
      time2 = Time.new(2014, 8, 29, 2, 30, 30) 
      expect(Exercises.ex10(time2)).to eq("normal prices")
    end

  end
  

end