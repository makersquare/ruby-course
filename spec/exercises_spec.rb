require './exercises'

describe Exercises do
	before do
		@numbers = [5, 10, 15, 20, 25]
		@animals = ['tiger', 'lion', 'crocodile', 'snake']
	end
	
	describe "Exercise 0" do
		it "triples a given string" do
			result = Exercises.ex0('ho')
			expect(result).to eq 'hohoho'
		end

		it "returns 'nope' if string is 'wishes'" do
			result = Exercises.ex0('wishes')
			expect(result).to eq 'nope'
		end

		describe "Exercise 1" do
			it "returns the number of elements in the array" do
				result = Exercises.ex1(@animals)
				expect(result).to eq(4)
			end
		end

		describe "Exercise 2" do
			it "returns the second element of an array" do
				result = Exercises.ex2(@animals)
				expect(result).to eq 'lion'
			end
		end

		describe "Exercise 3" do
			it "returns the sum of the given array of numbers" do
				result = Exercises.ex3(@numbers)
				expect(result).to eq(75)
			end
		end

		describe "Exercise 4" do
			it "returns the max number of the given array" do
				result = Exercises.ex4(@numbers)
				expect(result).to eq(25)
			end
		end

		describe "Exercise 5" do
			it "iterates through an array and `puts` each element" do
				expect(STDOUT).to receive(:puts).with('tiger')
				expect(STDOUT).to receive(:puts).with('lion')
				expect(STDOUT).to receive(:puts).with('crocodile')
				expect(STDOUT).to receive(:puts).with('snake')
				result = Exercises.ex5(@animals)
			end
		end

		describe "Exercise 6" do
			it "updates the last item in the array to 'panda'" do
				result = Exercises.ex6(@animals, 'panda')
				expect(result).to eq 'panda'
			end

			it "updates it to 'GODZILLA' if the last item is 'panda'" do
				animals1 = @animals << 'panda'
				result = Exercises.ex6(animals1, 'panda')
				expect(result).to eq 'GODZILLA'
			end
		end

		describe "Exercise 7" do
			it "add a string to the end of the array, if the string exists in array" do
				result = Exercises.ex7(@animals, 'lion')
				expect(result).to eq(["tiger", "lion", "crocodile", "snake", "lion"])
			end
		end

		describe "Exercise 8" do
			it "iterate through `people` and print out their name and occupation." do
				expect(STDOUT).to receive(:print).with('Bob')
				expect(STDOUT).to receive(:print).with('Builder')
				people = { :name => 'Bob', :occupation => 'Builder' }
				result = Exercises.ex8(people)
			end
		end
	end
end