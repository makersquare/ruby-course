
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
		result = Exercises.ex6([1, 2, 3, 4])
		expect(result).to eq([1,2,3,'panda'])
	end

	it "updates the last item in the array to GODZILLA" do
		result = Exercises.ex6([1, 2, 3, 'panda'])
		expect(result).to eq([1, 2, 3, 'GODZILLA'])
	end

	it "if the string 'str' exists in the array add 'str' to the array" do
		result = Exercises.ex7(['apples', 2, 3], 'apples')
		expect(result).to eq(['apples', 2, 3, 'apples'])
	end

	it "prints peoples occupations to stdout" do
		people = [
			{name: "kizzle", occupation: "oil and gas"},
			{name: "ravi", occupation: "boss"}
		]
		Exercises.should_receive(:print).with("kizzle: oil and gas")
		Exercises.should_receive(:print).with("ravi: boss")

		Exercises.ex8(people)
	end

	it "returns 'true' if the given time is in a leap year otherwise returns 'false'" do
		year1 = Exercises.ex9(800)
		year2 = Exercises.ex9(2014)
		year3 = Exercises.ex9(2004)

		expect(year1).to be true
		expect(year2).to be false
		expect(year3).to be true
	end


	it "returns happy our between 4 and 6 pm" do
		early = Time.parse("11 am")
		late = Time.parse("5:30 pm")

		Time.stub(:now).and_return(early)
		expect(Exercises.ex10).to eq("normal prices")

		Time.stub(:now).and_return(late)
		expect(Exercises.ex10).to eq("happy hour")
	end
end


describe 'Extensions' do
	it "Takes an array of strings. Returns a hash with two keys. If any tie for most or least, return an array of an array of the tying strings" do
		result = Extensions.extremes(['x', 'x', 'y', 'z'])
  	expect(result).to eq({ :most => 'x', :least => ['y', 'z'] })
	end
end