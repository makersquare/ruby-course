require 'spec_helper'

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
    it "returns the number of elements in the array" do
      result = Exercises.ex1([1,2,3,4,5])
      expect(result).to eq(5)
    end
end

describe 'Exercise 2' do
    it "returns the second element of an array" do
      result = Exercises.ex2(["cat","dog", "mouse","bird"])
      expect(result).to eq("dog")
    end
end

describe 'Exercise 3' do
  it "returns the sum of the given array of numbers" do
    result = Exercises.ex3([1,2,3,4,5])
    expect(result).to eq(15)
  end
end

describe 'Exercise 4' do
  it "returns the max number of the given array" do
    result = Exercises.ex4([1,44, 2, 98, 15])
    expect(result).to eq(98)
  end
end

describe 'Exercise 5' do
  it "iterates through an array and puts each element" do
    expect(STDOUT).to receive(:puts).with(1)
    expect(STDOUT).to receive(:puts).with("blue")
    expect(STDOUT).to receive(:puts).with("dog")
    Exercises.ex5([1, "blue", "dog"])
  end
end

describe 'Exercise 6' do

  it "updates the last item in the array to panda" do
    result = Exercises.ex6(["cat", "lemming", "elephant"])
    expect(result.count).to eq(3)
    expect(result.last).to eq("panda")
  end

  it "updates last item in array to GODZILLA if already panda" do
    result = Exercises.ex6(["cat", "lemming","bird", "panda" ])
    expect(result.count).to eq(4)
    expect(result.last).to eq("GODZILLA")
  end

end

describe 'Exercise 7' do
  it "adds str to end of array if already exists in array" do
    result = Exercises.ex7(["Hello", 17 ,"Goodbye", 12], "Goodbye")
    expect(result.count).to eq(5)
    expect(result.last).to eq("Goodbye")
    no_str = Exercises.ex7(["Hello", 17 ,"Goodbye", 12], "Hey")
    expect(no_str.count).to eq(4)
    expect(no_str.last).to eq(12)
  end
end


describe 'Exercise 8' do
  it "prints name and occupation values within array of hashes" do
    expect(STDOUT).to receive(:puts).with("Mary: engineer")
    expect(STDOUT).to receive(:puts).with("Jane: president")
    expect(STDOUT).to receive(:puts).with("Sophie: mathematician")
    Exercises.ex8([{:name =>"Mary", :occupation => "engineer"}, {:name => "Jane", :occupation => "president"}, {:name => "Sophie", :occupation =>"mathematician"}])
  end
end

describe "Exercise 9" do
  it "returns true if the given time is in a leap year" do
  leap_year = Time.new(2012,6,21, 13,30,0, "+09:00")
    result = Exercises.ex9(leap_year)
    expect(result).to eq(true)
  end
end

describe "RPS" do

  before do
    @new_game = RPS.new("Rambo", "Killa")
  end

  it "initializes with two players" do
    expect(@new_game.player1).to eq("Rambo")
    expect(@new_game.player2).to eq("Killa")
  end

  # it "inializes with 0 rounds" do
  #   expect(@new_game.num_rounds).to eq(0)
  # end

  describe "play" do
    it "determines the winner of the round" do
      result = @new_game.play("rock", "scissors")
      expect(result).to eq("Rambo wins the round!")
      result = @new_game.play("scissors", "rock")
      expect(result).to eq("Killa wins the round!")
    end

    it "returns the winner of the game" do
      result = @new_game.play("rock", "scissors")
      expect(result).to eq("Rambo wins the round!")
      result = @new_game.play("scissors", "rock")
      expect(result).to eq("Killa wins the round!")
      result = @new_game.play("paper", "scissors")
      expect(result).to eq("Killa wins the game!")
      expect(@new_game.p2_wins).to eq(2)
      expect(@new_game.p1_wins).to eq(1)
    end

    it "tells players when game is over" do
      result = @new_game.play("rock", "scissors")
      expect(result).to eq("Rambo wins the round!")
      result = @new_game.play("scissors", "rock")
      expect(result).to eq("Killa wins the round!")
      result = @new_game.play("paper", "scissors")
      expect(result).to eq("Killa wins the game!")
      result = @new_game.play("rock", "scissors")
      expect(result).to eq("The game is over.")
    end
  end
end
