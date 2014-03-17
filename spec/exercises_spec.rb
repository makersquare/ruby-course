require "./exercises.rb"
require "time"

describe "Exercises" do

  it "can return triples of a given string" do
    result=Exercises.ex0("ha")
    expect(result).to eq("hahaha")
  end

  it "returns 'nope' if the stirng is 'wishes'" do
    result=Exercises.ex0("wishes")
    expect(result).to eq("nope")
  end

  it "returns the number of elements in the array" do
    result=Exercises.ex1(["fighting", "yell","shout"])
    expect(result).to eq(3)
  end

  it "returns the second element of the array" do
    result=Exercises.ex2(["fighting","yell","shout"])
    expect(result).to eq("yell")
  end

  it "returns the sum of the given array of numbers" do
    result=Exercises.ex3([1,2,3])
    expect(result).to eq(6)
  end

  it "returns the max number of the given array" do
    result=Exercises.ex4([1,2,3])
    expect(result).to eq(3)
  end

  it "iterates through array and 'puts' each element" do
    STDOUT.should_receive(:puts).with("hello")
    STDOUT.should_receive(:puts).with("morning")
    STDOUT.should_receive(:puts).with("glory")
    result=Exercises.ex5(["hello","morning","glory"])
  end

  it "updates last item in array to 'panda'"do
    result=Exercises.ex6(["hello","morning","glory"],"panda")
    expect(result).to eq(["hello","morning","glory","panda"])
  end
  it "updates to GODZILLA if last item is already 'panda" do
    result=Exercises.ex6(["hello","morning","glory","panda"],"panda")
    expect(result).to eq(["hello","morning","glory","panda","GODZILLA"])
  end

  it "adds str to end of the array if it exists in array" do
    result=Exercises.ex7(["hello","chocolate","pie"],"chocolate")
    expect(result).to eq(["hello","chocolate","pie","chocolate"])
  end

  it "iterates through an array of hashes and prints out key and value"do
    STDOUT.should_receive(:puts).with("Bob: Builder")
    STDOUT.should_receive(:puts).with("Casper: Ghost")
    result=Exercises.ex8([{:name=> "Bob", :occupation=>"Builder"},{:name =>"Casper", :occupation => "Ghost"}])
  end

  it "returns true if given time is in a leap year" do
    given_time=DateTime.parse("2014-03-02")
    DateTime.stub(:now).and_return(given_time)
    result=Exercises.ex9(DateTime.now)
    expect(result).to eq(false)

    given_time2=DateTime.parse("2016-02-04")
    DateTime.stub(:now).and_return(given_time2)
    result2 = Exercises.ex9(DateTime.now)
    expect(result2).to eq(true)
  end
end



describe "RPS" do

  it "initilize with 2 players names" do
    game=RPS.new("wendy","andy")
    expect(game.player1).to eq("wendy")
    expect(game.player2).to eq("andy")
  end

end

