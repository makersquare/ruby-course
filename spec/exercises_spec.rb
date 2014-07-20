require 'pry-byebug'
require "./exercises.rb"

#ex 9
describe 'Exercises' do
 it "it gives nope if string is wishes " do
    expect(Exercises.ex0("wishes")).to eq("nope")
  end
#ex1 
it "Returns the number of elements in the array" do 
    expect(Exercises.ex1([1,2,3])).to eq(3)
end 

#ex 2 Returns the second element of an array
it "Returns the second element of an array " do
    expect(Exercises.ex2([1,2,3])).to eq(2)
  end
#ex3 Returns the sum of the given array of numbers
it "Returns the sum of the given array of numbers" do
  expect(Exercises.ex3([1,2,3])).to eq(6)
end 

it "Returns the max number of the given array" do
  expect(Exercises.ex4([1,2,3])).to eq(3)
end 

it "Returns the max number of the given array" do
  expect(Exercises.ex4([-1,-2,-3])).to eq(-1)
end 

it "Returns the max number of the given array" do
  expect(Exercises.ex4([2,2,3, 3, -1, 0, 1])).to eq(3)
end 


#ex5 
# it "Iterates through an array and `puts` each element" do
#   expect(Exercises.ex5(["hey", "hi"]).to eq("hey"\n "hi"\n)
# end "

#ex 6 
it "Updates the last item in the array to 'panda'If the last item is already 'panda', update
 it to 'GODZILLA' instead " do 
  expect(Exercises.ex6(['ciao', 'hello', 'panda'])).to eq('GODZILLA')
end 


#ex7 
it "If the string `str` exists in the array" do 
 expect(Exercises.ex7(['ciao', 'hello', 'panda'], 'ciaoooo')).to eq(['ciao', 'hello', 'panda', 'ciaoooo'])
end 


# #ex8 
# it "- `people` is an array of hashes. Each hash is like the following:
#   #  { :name => 'Bob', :occupation => 'Builder' }" do 
# expect(Exercises.ex8({ :name => 'Bob', :occupation => 'Builder' })).to eq("Bob Builder")
# end 

it "Returns `true` if the given time is in a leap year. 
Otherwise, returns `false`" do 
expect(Exercises.ex9(2000)).to eq(true)
end 

it "Returns `true` if the given time is in a leap year. 
Otherwise, returns `false`" do 
expect(Exercises.ex9(1800)).to eq(false)
end 

end 

