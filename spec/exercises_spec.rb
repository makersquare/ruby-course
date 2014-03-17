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
end
