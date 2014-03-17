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
end
