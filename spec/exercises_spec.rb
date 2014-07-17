require 'rubygems'
require 'rspec'
require_relative "../exercises.rb"

describe "Exercises" do
  it "should work" do
    expect(true).to eq(true)
  end

  describe "ex0" do
    it "triples the length of a string" do
      result = Exercises.ex0 "ha"
      expect(result).to eq("hahaha")
    end

    it "returns 'nope' if the string is 'wishes'" do
      result = Exercises.ex0 "wishes"
      expect(result).to eq("nope")
    end
  end

  describe "ex1" do
    it "should return 0 for an empty array" do
      result = Exercises.ex1 []
      expect(result).to eq(0)
    end

    it "should return the size of an array" do
      result = Exercises.ex1 [4, 3, 2, 5]
      expect(result).to eq(4)
    end
  end

  describe "ex2" do
    it "should return nil for an array shorter than 2 elements" do
      result = Exercises.ex2 []
      expect(result).to eq(nil)

      result = Exercises.ex2 [1]
      expect(result).to eq(nil)
    end

    it "should return the second element of a longer array" do
      result = Exercises.ex2 [4, 5]
      expect(result).to eq(5)

      result = Exercises.ex2 [1, 2, 3]
      expect(result).to eq(2)
    end
  end

  describe "ex3" do
    it "should sum up an array" do
      result = Exercises.ex3 [5,6,7]
      expect(result).to eq(18)
    end
  end

  describe "ex4" do
    it "should return the largest number in this array" do
      result = Exercises.ex4 [9,3,2,5]
      expect(result).to eq(9)
    end
  end

  describe "ex5" do
    it "should print every element in an array" do
      STDOUT.should_receive(:puts).with(1)
      STDOUT.should_receive(:puts).with(2)
      STDOUT.should_receive(:puts).with("b")
      STDOUT.should_receive(:puts).with("c")
      Exercises.ex5 [1, 2, 'b', 'c']
    end
  end

  describe "ex7" do
    it "doesn't change the array if it doesn't have str" do
      result = Exercises.ex7(["alpha", "beta", "gamma"], "hello")
      expect(result).to eq(["alpha", "beta", "gamma"])
    end

    it "adds str to the end of the array if its included" do
      result = Exercises.ex7(["alpha", "beta", "gamma"], "beta")
      expect(result).to eq(["alpha", "beta", "gamma", "beta"])
    end
  end

  describe "ex6" do
    it "changes last element in array to panda" do
      result = Exercises.ex6 [5,6,7]
      expect(result).to eq([5, 6, "panda"])
    end

    it "changes last element in array to GODZILLA if its panda" do
      result = Exercises.ex6 [5,6,"panda"]
      expect(result).to eq([5, 6, "GODZILLA"])
    end
  end

  describe "ex8" do
    it "should print off each persons name and occupation" do
      STDOUT.should_receive(:puts).with("bob builder")
      STDOUT.should_receive(:puts).with("dora explorer")
      Exercises.ex8 [
        {name: "bob", occupation: "builder"},
        {name: "dora", occupation: "explorer"}
      ]
    end
  end

  describe "ex9" do
    it "should return true for leap years" do
      Time.stub(:now).and_return(Time.parse("2012-1-2 11:00:00"))
      result = Exercises.ex9 Time.now
      expect(result).to eq(true)
    end

    it "should return false for other years" do
      Time.stub(:now).and_return(Time.parse("2013-1-2 11:00:00"))
      result = Exercises.ex9 Time.now
      expect(result).to eq(false)
    end
  end
end

describe "RPS" do
  describe "initialize" do
    it "should set player names and initial score" do
      game = RPS.new("John", "Bob")
      expect(game.player1).to eq("John")
      expect(game.player2).to eq("Bob")
      expect(game.score).to eq({"John" => 0, "Bob" => 0})
    end
  end

  describe "play" do
    before(:each) do
      @game = RPS.new("John", "Bob")
    end

    it "should update the score and return winner when a game is won" do
      result = @game.play("rock", "paper")
      expect(@game.score).to eq({"John" => 0, "Bob" => 1})
      expect(result).to eq("Bob wins")

      result = @game.play("scissors", "paper")
      expect(@game.score).to eq({"John" => 1, "Bob" => 1})
      expect(result).to eq("John wins")
    end

    it "should not update the score if its a tie" do
      @game.play("rock", "rock")
      expect(@game.score).to eq({"John" => 0, "Bob" => 0})

      # only 1 of the next 2 games has a winner
      @game.play("rock", "paper")
      @game.play("rock", "rock")
      expect(@game.score).to eq({"John" => 0, "Bob" => 1})
    end

    it "should return 'tie game' when the round is tied" do
      result = @game.play("rock", "rock")
      expect(result).to eq("Tie game")

      # only 1 of the next 2 games has a winner
      @game.play("rock", "paper")
      result = @game.play("rock", "rock")
      expect(result).to eq("Tie game")
    end
    
    it "should return an error string if the game is over" do
      @game.play("rock", "paper")
      @game.play("rock", "paper")
      result = @game.play("rock", "paper")

      expect(result).to eq("Game is already over")
    end
  end
end
