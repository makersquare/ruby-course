require "./exercises.rb"
require 'pry-byebug'
require 'time'
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
    result = Exercises.ex1([1,2,3,4,"c"])
    expect(result).to eq(5)
  end

  it "returns zero if array is empty'" do
    result = Exercises.ex1([])
    expect(result).to eq(0)
  end
end

describe 'Exercise 2' do
  it "returns the second element of an array" do
    result = Exercises.ex2([1,"b",3,4,"c"])
    expect(result).to eq("b")
  end
end

describe 'Exercise 3' do
  it "returns the sum of the given array of numbers" do
    result = Exercises.ex3([1,2,3,4])
    expect(result).to eq(10)
  end

  it "returns zero if array is empty'" do
    result = Exercises.ex3([])
    expect(result).to be_nil
  end
end

describe 'Exercise 4' do
  it "returns the max number of the given array" do
    result = Exercises.ex4([6,-2,3,4])
    expect(result).to eq(6)
  end

  it "returns nil if array is empty'" do
    result = Exercises.ex4([])
    expect(result).to be_nil
  end
end

describe 'Exercise 5' do
  it "puts each element of an array on it's own line" do
    array = [1, 2, 3]
    expect(STDOUT).to receive(:puts).and_return(1)
    expect(STDOUT).to receive(:puts).and_return(2)
    expect(STDOUT).to receive(:puts).and_return(3)
    result = Exercises.ex5(array)
  end

  it "puts each element of an array on it's own line" do
    array = []
    result = Exercises.ex5(array)
    expect(result).to eq([])
  end
end

describe 'Exercise 6' do
  it "Updates the last item in the array to 'panda'
  -If the last item is already 'panda', update
    it to 'GODZILLA' instead" do
    result = Exercises.ex6(["ciao", "panda"])
    expect(result).to eq(["ciao", "GODZILLA"])
  end

  it "returns nil if array is empty'" do
    result = Exercises.ex6(["ciao", "panda", "cat"])
    expect(result).to eq(["ciao", "panda", "panda"])
  end
end


describe 'Exercise 7' do
  it "If the string `str` exists in the array,
    add `str` to the end of the array" do
    array = ["ciao", "panda"]
    string = "panda"
    result = Exercises.ex7(array, string)
    expect(result).to eq(["ciao", "panda", "panda" ])
  end

  it "does not add string if string is not in the array'" do
    array = ["ciao", "panda"]
    string = "cat"
    result = Exercises.ex7(array, string)
    expect(result).to eq(["ciao", "panda"])
  end
end

describe 'Exercise 8' do
  it "prints names and jobs from hash" do
    alice = { name: "Alice", job: "Teacher" }
    mary = { name: "Mary", job: "Cook" }
    array = Array.new.push(alice, mary)
    expect(STDOUT).to receive(:puts).and_return("Alice Teacher")
    expect(STDOUT).to receive(:puts).and_return("Mary Cook")
    result = Exercises.ex8(array)
  end
end

describe 'Exercise 9' do
  it "returns true if a leap year" do
    time = Time.new(2012)
    result = Exercises.ex9(time)
    expect(result).to be true
  end  

  it "returns false if not" do
    time = Time.new(2014)
    result = Exercises.ex9(time)    
    expect(result).to be false
  end
end



describe 'Exercise 10' do
  it "returns happy hour if it is between 4 and 6pm
    Otherwise, returns normal prices" do
    Time.stub(:now).and_return(Time.mktime(2014,1,1,14))
    result = Exercises.ex10
    expect(result).to eq("normal prices")
  end

  it "returns happy hour if it is between 4 and 6pm
    Otherwise, returns normal prices" do
    Time.stub(:now).and_return(Time.mktime(2014,1,1,17))
    result = Exercises.ex10
    expect(result).to eq("happy hour")
  end
end


#   it "does not add string if string is not in the array'" do
#     array = ["ciao", "panda"]
#     string = "cat"
#     result = Exercises.ex7(array, string)
#     expect(result).to eq(["ciao", "panda"])
#   end
# end


# describe 'Exercise 11' do
#   it "returns the sum of two numbers if they are both integers
#     Raises an error if both numbers are not integers" do
#     result = Exercises.ex11(3, 7)
#     # result1 = Exercises.ex11(1.3, 7)
#     expect(result).to eq(10)
#     # expect(result).to eq("error")
#   end
#   it "raises an error if both numbers are not integers" do
#     result = Exercises.ex11(1.3, 7)
#     expect { raise StandardError, 'Enter Integers!'}.to raise_error('Enter Integers!')

#   end  
# end

describe 'Exercise 12' do
  it "takes two characters and returns and ordered array 
  with all characters need to fill the range" do
    result = Exercises.ex12('c', 'g')
    expect(result).to eq(['c', 'd', 'e', 'f', 'g'])
  end
end

describe 'Extension' do
  it "takes an array of strings. Returns a hash with two keys:
    :most => the string(s) that occures the most # of times as its value.
   :least => the string(s) that occures the least # of times as its value.
    If any tie for most or least, return an array of the tying strings" do
    result = Extensions.extremes(['x', 'x', 'y', 'z'])
    result1 = Extensions.extremes(['x', 'y', 'y', 'z', 't', 'p'])
    expect(result).to eq({ :most => 'x', :least => ['y', 'z'] })
    expect(result1).to eq({ :most => 'y', :least => ['x', 'z', 't', 'p'] })

  end

end


