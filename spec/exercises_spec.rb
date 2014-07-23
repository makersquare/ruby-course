require "./exercises.rb"

describe 'Exercise 0' do
  it "triples the length of a string" do
    result = Exercises.ex0("ha")
    expect(result).to eq("hahaha")
  end

  it "returns 'nope' if the string is 'wishes'" do
    result = Exercises.ex0("wishes")
    expect(result).to eq("nope")
  end
end

describe 'Exercise 1' do
  it "finds the number of elements in an array" do
    array = %w(big, dog, jogs, all, day)
    result = Exercises.ex1(array)
    expect(result).to eq(5)    
  end  
end

describe 'Exercise 2' do
  it "returns the second item in an array" do
    array = %w(wow there is a big dragon)
    result = Exercises.ex2(array)
    expect(result).to eq("there")
  end  
end
  
describe 'Exercise 3' do
  it "returns the sum of all the numbers in an array" do
    array = (1..5).to_a
    result = Exercises.ex3(array)
    expect(result).to eq(15)
  end
end

describe 'Exercise 4' do
  it "returns the largest number in the array" do
    array = [1, 100, 4, 3.5, 99, 47.1]
    result = Exercises.ex4(array)
    expect(result).to eq(100)
  end
end

describe 'Exercise 5' do
  it "puts each element of an array on it's own line" do
    array = [1, 2, 3]
    expect(STDOUT).to receive(:puts).and_return(1)
    expect(STDOUT).to receive(:puts).and_return(2)
    expect(STDOUT).to receive(:puts).and_return(3)
    result = Exercises.ex5(array)
  end
end

describe 'Exercise 6' do
  it "changes the last item of the array to 'panda'" do
    array = %w(big brown bear)
    result = Exercises.ex6(array)
    expect(result).to eq(["big", "brown", "panda"])
  end

  it "changes the last item to 'GODZILLA' if it's 'panda'" do
    array = %w(big brown panda)
    result = Exercises.ex6(array)
    expect(result).to eq(["big", "brown", "GODZILLA"])
  end
end

describe 'Exercise 7' do
  it "adds string to the end of array if preexisting" do
    array = [1, 2, "blue", "red", 5]
    str = "blue"
    result = Exercises.ex7(array, str)
    expect(result).to eq([1, 2, "blue", "red", 5, "blue"])
  end

  it "leaves array unchanged if sting not present" do
    array = [1, 2, "blue", "red", 5]
    str = "purple"
    result = Exercises.ex7(array, str)
    expect(result).to eq([1, 2, "blue", "red", 5])
  end
end

describe 'Exercise 8' do
  it "prints names and jobs from hash" do
    bob = { name: "Bob", job: "Builder" }
    joe = { name: "Joe", job: "Jammer" }
    array = Array.new.push(bob, joe)
    expect(STDOUT).to receive(:puts).and_return("Bob Builder")
    expect(STDOUT).to receive(:puts).and_return("Joe Jammer")
    result = Exercises.ex8(array)
  end
end

describe 'Exercise 9' do
  it "returns true if leap year" do
    time = Time.new(2012)
    time2 = Time.new(2000)
    result = Exercises.ex9(time)
    result2 = Exercises.ex9(time2)
    expect(result).to be true
    expect(result2).to be true
  end  

  it "returns false if not" do
    time = Time.new(2014)
    time2 = Time.new(1900)
    result = Exercises.ex9(time)    
    result2 = Exercises.ex9(time2)
    expect(result).to be false
    expect(result2).to be false
  end
end

describe 'RPS' do
  before do
    @g1 = RPS.new("Joe", "Bob")
  end
  
  describe ".initialize" do
    it "makes a new game with two players whose names are strings" do
      expect(@g1.player1).to eq("Joe")
      expect(@g1.player2).to eq("Bob")
    end

    it "starts the game with scores of 0" do
      expect(@g1.p1score).to eq(0)
      expect(@g1.p2score).to eq(0)
    end
  end

  describe "#play" do
    it "increases one score and leaves the other the same" do
      @g1.play("s", "p")
      expect(@g1.p1score).to eq(1)
      expect(@g1.p2score).to eq(0)
      @g1.play("r", "p")    
      expect(@g1.p1score).to eq(1)
      expect(@g1.p2score).to eq(1)
    end

    it "returns :tie for tied games" do
      result = @g1.play("s", "s")
      expect(result).to be :tie
    end

    it "returns a symbol denoting who won" do
      result = @g1.play("s", "p")
      expect(@g1.p1score).to eq(1)
      expect(result).to eq(:win1)
    end

    it "returns a symbol when game is won - 2 of 3" do
      @g1.play("s", "p")
      result = @g1.play("s", "p")
      expect(@g1.p1score).to eq(2)
      expect(result).to eq(:gameover1)
    end
  end
end

describe Extensions do
  it "returns an array of max and min values" do
    result = Extensions.extremes(['x', 'x', 'y', 'z'])
    expect(result).to eq({ :most => 'x', :least => ['y', 'z'] })
  end
end




