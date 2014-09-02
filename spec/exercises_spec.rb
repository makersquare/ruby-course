#write the specs first. then implement your method
require './exercises.rb'
require 'rspec'

describe Exercises do
  it "exists" do 
    expect(Exercises).to be_a(Module)
  end
# don't put the damn method call directly in the argument field
#instead store it in a variable withs something like 'results'. 
  describe '.ex0' do
    it "triples a given string" do

      expect(Exercises.ex0("money")).to eq("moneymoneymoney")
    end
    it "returns 'nope' if string passed is 'wishes'" do

      expect(Exercises.ex0("wishes")).to eq("nope")
    end
  end

  describe '.ex1' do
    it 'returns the number of elements in the array' do

      expect(Exercises.ex1([5,3,2])).to eq(3)
    end
  end

  describe '.ex2' do
    it 'returns the second element of an array' do

      expect(Exercises.ex2([0,3,5])).to eq(3)
    end
  end

  describe '.ex3' do
    it 'returns the sum of the given array of numbers' do

      expect(Exercises.ex3([100,300])).to eq(400)
    end
  end
  describe '.ex4' do
    it 'returns the max number of the given array' do

      expect(Exercises.ex4([3,10,99])).to eq(99)
    end
  end
  describe '.ex5' do 
    #I don't know how to call the method so that STDOUT sees the stuff. 
    #same thing for ex8. I am such a sad panda. 
    it 'iterates through an array and puts each element' do

    test = ["Monkeys", "are", "too", "kewl"]

    STDOUT.should_receive(:puts).with("Monkeys")
    STDOUT.should_receive(:puts).with("are")
    STDOUT.should_receive(:puts).with("too")
    STDOUT.should_receive(:puts).with("kewl")
    Exercises.ex5(test)
  end
  end

  describe '.ex6' do
    it 'Updates the last item in the array to "panda"' do

      expect(Exercises.ex6(["i","love","pizza"])).to eq("panda")
    end

    it 'changes the last array item to GODZILLA if it was panda' do

      expect(Exercises.ex6(['i','love','panda'])).to eq('GODZILLA')
    end
  end

  describe '.ex7' do
    it 'adds "manatee" to the end of the array if the string "manatee" exists in the array' do

      expect(Exercises.ex7(["monkey", "farm", "manatee"], 'manatee').last).to eq('manatee')
    end
  end

  describe '.ex8' do
    #WHY U NO WORK EXERCISE 8
    it 'iterates through an array of hashes and print out name and occupation' do
      people = [
        {name: 'nick', occupation: "Karate Chopper"}, 
        {name: 'fred', occupation: "Breakdancer"}
      ]
      
      
      STDOUT.should_receive(:puts).with("nick: Karate Chopper")
      STDOUT.should_receive(:puts).with("fred: Breakdancer")
      Exercises.ex8(people)
    end
  end

  describe '.ex9' do
    it 'returns "true" if the given time is in a leap year - else returns false' do

      expect(Exercises.ex9(2012)).to be_true
    end

    it "returns 'false' if the year passed is 1900" do

      expect(Exercises.ex9(1900)).to be_true
    end
  end

   describe '.ex10' do
     it 'returns happy hour if it is between 4 and 6pm -else returns "normal prices"' do
      time = Time.new(1982, 05, 31, 16, 2, 2, "-05:00")

      expect(Exercises.ex10(time)).to eq("Normal Prices")
     end
   end


end