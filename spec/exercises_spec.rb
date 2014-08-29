
require "./exercises.rb"

describe 'Exercise'  do 
	it "triples the string of a string" do
		result = Exercises.ex0("ha")
		expect(result).to eq("hahaha")
	end

	it "returns 'nope' if the string is 'wishes" do
		result = Exercises.ex0("wishes")
		expect(result).to eq("nope")
	end

	it "returns the number of elements in the array" do
		result = Exercises.ex1([1,2,3])
		expect(result).to eq(3)
	end

	it "returns the second element of the array" do
		result = Exercises.ex2([1,2,3])
		expect(result).to eq(2)
	end

	it "returns the sume of the given array of numbers" do
		result = Exercises.ex3([1,2,3])
		expect(result).to eq(6)
	end

	it "returns the max number of the given array" do
		result = Exercises.ex4([1, 2, 3])
		expect(result).to eq(3)
	end

	it "iterates through an array and 'puts' each element" do      
    STDOUT.should_receive(:puts).with("a")
    STDOUT.should_receive(:puts).with("b")
    STDOUT.should_receive(:puts).with("c")

    Exercises.ex5(["a","b","c"]) 
  end

  it "updates the last item in the array to 'panda'" do
		
	end
end



