require "./exercises.rb"

describe Exercises do
  describe "Exercise 0" do
    it "triples a given string 'str'" do
      result = Exercises.ex0('hello')
      expect(result).to eq('hellohellohello')
    end
  end
end
