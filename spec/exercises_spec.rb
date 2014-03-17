require "./exercises.rb"

describe Exercises do
  describe "Exercise 0" do
    it "triples a given string 'str'" do
      result = Exercises.ex0('hello')
      expect(result).to eq('hellohellohello')
    end

    it "returns nope if the string is wishes" do
      result = Exercises.ex0('wishes')
      expect(result).to eq('nope')
    end
  end

  describe "Exercise 1" do
    it "Returns the numer of elements in the array" do
      testarray = [1, 2, 3]
      expect( Exercises.ex1(testarray) ).to eq(3)
    end
  end

  describe "Exercise 2" do
    it "Returns the second element of an array" do
      testarray = [1, 2, 3, 4, 5]
      expect( Exercises.ex2( testarray ) ).to eq(2)
    end
  end

  describe "Exercise 3" do
    it "Returns the some of the given array of numbers" do
      testarray = [1, 2, 3, 4, 5]
      expect( Exercises.ex3( testarray ) ).to eq(15)
    end
  end

  describe "Exercise 4" do
    it "Returns the max number of the given array" do
      testarray = [2, 4, 9, 1, 6]
      expect( Exercises.ex4( testarray ) ).to eq(9)
    end
  end

  describe "Exercise 5" do
    it "Iterates through an array and 'puts' each element" do
      testarray = [1, 2, 3, 4, 5]

      expect(STDOUT).to receive(:puts).with(1)
      expect(STDOUT).to receive(:puts).with(2)
      expect(STDOUT).to receive(:puts).with(3)
      expect(STDOUT).to receive(:puts).with(4)
      expect(STDOUT).to receive(:puts).with(5)

      Exercises.ex5( testarray )
    end
  end

  describe "Exercise 6" do
    it "Updates the last item in the array to panda" do
      testarray = ["kangaroo", "koala", "snake", "tiger"]

      Exercises.ex6(testarray,"")

      result = testarray.last

      expect( result ).to eq("panda")
    end

    it "If the last item is already 'panda', update to 'Godzilla' instead" do
      testarray = ["kangaroo", "koala", "snake", "panda"]

      Exercises.ex6(testarray,"")

      result = testarray.last

      expect( result ).to eq("GODZILLA")
    end
  end

  describe "Exercise 7" do
    it "Does not insert string that is not already there" do
      testarray = ["kangaroo", "koala", "snake", "tiger"]
      Exercises.ex7(testarray,"lion")

      expect( testarray.last ).to_not eq("lion")
    end

    it "Does insert a string that is already there" do
      testarray = ["kangaroo", "koala", "snake", "tiger"]
      Exercises.ex7(testarray,"snake")
      expected = ["kangaroo", "koala", "snake", "tiger", "snake"]

      expect( testarray ).to eq( expected )
    end
  end

  describe "Exercise 8" do
    it "Iterates through array of hashes and prints name and occupation" do
      testarray = [{ :name => 'Bob', :occupation => 'Builder' }, { :name => 'Sam', :occupation => 'Teacher' }, { :name => 'Brian', :occupation => 'Job' }]

      expect(STDOUT).to receive(:puts).with("Bob: Builder")
      expect(STDOUT).to receive(:puts).with("Sam: Teacher")
      expect(STDOUT).to receive(:puts).with("Brian: Job")

      Exercises.ex8(testarray)
    end
  end

  describe "Exercise 9" do
    it "Returns true if given time is in a leap year" do
      Time.stub(:now).and_return(Time.new(2004))

      expect( Exercises.ex9( Time.now ) ).to eq(true)
    end

    it "Returns false if given time is not in a leap year" do
      Time.stub(:now).and_return(Time.new(2014))

      expect( Exercises.ex9( Time.now ) ).to eq(true)
    end
  end
end
