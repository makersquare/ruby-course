require './exercises.rb'

describe 'Exercise 0' do
  it "triples a given string" do
    result = Exercises.ex0("damn")
    expect(result).to eq("damndamndamn")
  end

  it "returns 'nope' if string is 'wishes'" do
    result = Exercises.ex0("wishes")
    expect(result).to eq("nope")
  end

end

describe 'Exercise 1' do
  it "returns the number of elements in an array" do
    array = [1,2,3]
    expect(Exercises.ex1(array)).to eq(3)
  end
end

describe 'Exercise 2' do
  it "returns the 2nd element of an array" do
    array = [1,2,3]
    expect(Exercises.ex2(array)).to eq(2)
  end
end

describe 'Exercise 3' do
  it "returns the sum of an array" do
    array = [1,2,3]
    expect(Exercises.ex3(array)).to eq(6)
  end
end

describe 'Exercise 4' do
  it "returns the max number in a given array" do
    array = [1,2,3]
    expect(Exercises.ex4(array)).to eq(3)
  end
end

describe 'Exercise 5' do
  it "puts each element of a given array" do
    array = ["dog", "cat", "gator"]
    STDOUT.should_receive(:puts).with("dog")
    STDOUT.should_receive(:puts).with("cat")
    STDOUT.should_receive(:puts).with("gator")
    Exercises.ex5(array)
  end
end

describe 'Exercise 6' do
  it "updates the last item in an array to 'Panda'" do
    array = ["dog", "cat", "gator"]
    Exercises.ex6(array, "Panda")
    array[-1].should eq('Panda')
  end

  it "updates the last item to 'GODZILLA' if str is already there" do
    array = ["dog", "cat", "Panda"]
    Exercises.ex6(array, "Panda")
    array[-1].should eq("GODZILLA")
  end
end

describe 'Exercise 7' do
  it "adds a string to the end of an array if it is already present" do
    array = ["dog", "cat", "gator"]
    Exercises.ex7(array, "cat")
    array.should eq(["dog", "cat", "gator", "cat"])
  end
end

describe 'Exercise 8' do
  it "prints each element of the people hash with proper formatting" do
    array = [{ name: "Bob",
              occupation: "drug-dealer" },
              { name: "Bill",
                occupation: "drug-consumer" },
                { name: "Billy",
                  occupation: "lazy musician" }]

    STDOUT.should_receive(:puts).with("Name: Bob")
    STDOUT.should_receive(:puts).with("Occupation: drug-dealer")
    STDOUT.should_receive(:puts).with("Name: Bill")
    STDOUT.should_receive(:puts).with("Occupation: drug-consumer")
    STDOUT.should_receive(:puts).with("Name: Billy")
    STDOUT.should_receive(:puts).with("Occupation: lazy musician")
    Exercises.ex8(array)
  end
end

describe 'Exercise 9' do
  it "determines if the given year is a leap year" do
    expect(Exercises.ex9(Time.new(1993))).to eq(false)
    expect(Exercises.ex9(Time.new(2000))).to eq(true)
  end
end



