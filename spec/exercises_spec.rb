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

	it "adds str to an array if str already exists" do
		result = Exercises.ex7(["hi","bye"], "bye")
		expect(result).to eq(["hi","bye","bye"])
	end

	it "iterates through array of hashes and prints out name and occupation" do
		
		STDOUT.should_receive(:puts).with("bob: waiter")
		STDOUT.should_receive(:puts).with("chris: student")
		result = Exercises.ex8([{:name => "bob", :occupation => "waiter"}, {:name=> "chris", :occupation => "student"}])
	end

	it "returns true if given time is in a leap year, else false" do

		result = Exercises.ex9(DateTime.now)
		expect(result).to eq(false)

		current_date = DateTime.parse('2016-01-02')
		DateTime.stub(:now).and_return(current_date)
		result2 = Exercises.ex9(DateTime.now)
		expect(result2).to eq(true)

	end
end

describe "RPS" do

	it "initializes with 2 names in parameter" do
		result = RPS.new("noel","sally")
		expect(result.name1).to eq("noel")
		expect(result.name2).to eq("sally")
	end

	it

end