require "./exercises.rb"
require 'pry-debugger'

describe Exercises do

  it "Ex 0, triples a given string" do
    tripleword = Exercises.ex0("hi")
    expect(tripleword).to eq ("hihihi")

    wishes = Exercises.ex0("wishes")
    expect(wishes).to eq ("nope")
  end

  it "Ex 1, Returns the number of elements in the array" do
    array = [1,2,"hi","bye",4]
    number_elements_array = Exercises.ex1(array)
    expect(number_elements_array).to eq (5)
  end

  it "Ex 2, Returns the second element of an array" do
    array = [1,2,"hi","bye",4]
    second_element_array = Exercises.ex2(array)
    expect(second_element_array).to eq (2)
  end

  it "Ex 3, Returns the sum of the given array of numbers" do
    array = [4,6,10,20,5]
    total_sum = Exercises.ex3(array)
    expect(total_sum).to eq (45)
  end

  it "Ex 4, Returns the max number of the given array" do
    array = [1,32423,5,64235,235325,235,325,23523235,235,324,24323,23535,32]
    max_num = Exercises.ex4(array)
    expect(max_num).to eq (23523235)

  end

  it "Ex 5, iterate through an array and puts each element" do
    array = ["see","you","later"]
    # expect(STDOUT).to_receive(:puts).and_return("see");
    $stdout.should_receive(:puts).with("see")
    $stdout.should_receive(:puts).with("you")
    $stdout.should_receive(:puts).with("later")

    expect(Exercises.ex5(array)).to eq (array)
    # STDOUT.should_receive(:puts).with('see')
    # STDOUT.should_receive(:puts).with('you')
    # STDOUT.should_receive(:puts).with('later')
    # run method after:
    # put_elements = Exercises.ex5(array)
    # expect(put_elements).to eq ["see", "you", "later"]
  end

  it "Ex, 6 Updates the last item in the array to panda, if already panda update to godzilla" do
    array = [1,2,"hi","bye",4]
    panda_last = Exercises.ex6(array,"panda")
    expect(panda_last).to eq [1,2,"hi","bye","panda"]

    array1 = [1,2,"hi","bye","panda"]
    godzilla_array = Exercises.ex6(panda_last,"panda")
    expect(godzilla_array).to eq [1,2,"hi","bye","GODZILLA"]
  end

  it "If the string str exists in the array, add str to end" do
    array = [1,2,"hi","bye",4,"easter",434,"yolo"]
    check_has = Exercises.ex7(array,"easter")
    expect(check_has).to eq [1,2,"hi","bye",4,"easter",434,"yolo","easter"]

    check_not = Exercises.ex7(array,"taco")
    expect(check_not).to eq nil
  end

  it "Iterate through has and print out name and occupation" do
    people = [{:name => 'Bob', :occupation => 'Builder' }, {:name => "joe",    :occupation => "cleaner"}, {:name => "john", :occupation => "chef"}]

    $stdout.should_receive(:puts).with("Bob is a Builder")
    $stdout.should_receive(:puts).with("joe is a cleaner")
    $stdout.should_receive(:puts).with("john is a chef")

    expect(Exercises.ex8(people)).to eq (people)

  end

  it "Return true if given time is in a leap year" do
    # okay you know you need to stub time. stub to to leap year then true

    # leapyear = Time.now(2400)
    # Time.stub(:now).and_return(leapyear)
    time = 1816
    Leap_test_true = Exercises.ex9(time)
    expect(Leap_test_true).to eq true

    time = 2013
    Leap_test_false = Exercises.ex9(time)
    expect(Leap_test_false).to eq false
  end

end

describe RPS do

  it "Initialized with two strings(playernames)" do
    newgame = RPS.new("Philip","Hubert")
    # expect(newgame.player1).to eq ("Philip")
  end



    #takes two strings --> players moves
    #returns winner
    # if over, retunrs a string --> over
    # ends after a player wins 2/3
  it "rock vs scissors, player 1 wins" do
    newgame = RPS.new("Philip","Hubert")
    expect(newgame.play("rock","scissors")).to eq ("Philip wins")
  end

  it "rock vs paper, player 2 wins" do
    newgame = RPS.new("Philip","Hubert")
    expect(newgame.play("rock","paper")). to eq ("Hubert wins")
  end


  it "rock vs rock, tie" do
    newgame = RPS.new("Philip","Hubert")
    expect(newgame.play("rock","rock")). to eq ("Tie game!")
  end


  it "scissors vs paper, player 1 wins" do
    newgame = RPS.new("Philip","Hubert")
    expect(newgame.play("scissors","paper")). to eq ("Philip wins")
  end


  it "scissors vs rock, player 2 wins" do
    newgame = RPS.new("Philip","Hubert")
    expect(newgame.play("scissors","rock")). to eq ("Hubert wins")
  end


  it "scissors vs scissors, tie" do
    newgame = RPS.new("Philip","Hubert")
    expect(newgame.play("scissors","scissors")). to eq ("Tie game!")
  end


  it "paper vs scissors, player 2 wins" do
    newgame = RPS.new("Philip","Hubert")
    expect(newgame.play("paper","scissors")). to eq ("Hubert wins")
  end


  it "paper vs rock, player 1 wins" do
    newgame = RPS.new("Philip","Hubert")
    expect(newgame.play("paper","rock")). to eq ("Philip wins")
  end


  it "paper vs paper, tie" do
    newgame = RPS.new("Philip","Hubert")
    expect(newgame.play("paper","paper")). to eq ("Tie game!")

  end

  it "should end after winning 2 games" do

    newgame = RPS.new("Philip","Hubert")
    newgame.play("rock","scissors")
    expect(newgame.play("rock","scissors")).to eq("Philip is the complete and utter victor")
  end

  it "should tell you to start a new game if you already won twice" do

    newgame = RPS.new("Philip", "Hubert")
    newgame.play("rock","scissors")
    newgame.play("rock","scissors")
    expect(newgame.play("rock", "scissors")).to eq("this game is over, start a new one sucka")
  end


end

describe RPSPlayer do

  it "Starts RPSPlayer" do
    newgame = RPSPlayer.new

  end


end
