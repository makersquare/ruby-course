require "./exercises.rb"

describe "exercises" do 
	it "triples a given string" do
		result = Exercises.ex0("hi")
		expect(result).to eq("hihihi")
	end

	it "returns the number of elements in an array" do 
		result = Exercises.ex1(["hi","bye"])
		expect(result).to eq(2);
	end

	it "returns the second element of the array" do
		result = Exercises.ex2(["hi","bye"])
		expect(result).to eq("bye")
	end

	it "returns the sum of the array" do
		result = Exercises.ex3([1,2,3])
		expect(result).to eq(6)
	end

	it "returns the max # of the array" do
		result = Exercises.ex4([1,2,3])
		expect(result).to eq(3)
	end

	it "iterates through array and puts each element" do
		
		STDOUT.should_receive(:puts).with("hi")
		STDOUT.should_receive(:puts).with("bye")
		result = Exercises.ex5(["hi","bye"])
	
	end

	it "updates last item in array to panda, if panda already, godzilla" do
		result = Exercises.ex6(["hello","goodbye"])
		expect(result).to eq(["hello","goodbye","panda"])

		result2 = Exercises.ex6(["hello", "panda"])
		expect(result2).to eq(["hello","panda","GODZILLA"])
	end

	

end