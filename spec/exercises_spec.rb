require "./exercises.rb"
require 'pry-byebug'


describe 'Exercises' do
  it "3x original string 'abc' => 'abcabcabc', unless str='wishes', then => 'nope'" do
    expect(Exercises.ex0('abc')).to eq 'abcabcabc'
    expect(Exercises.ex0('wishes')).to eq 'nope'
  end

  it "Returns the number of elements in the array" do
    expect(Exercises.ex1([1,2,3,4,5,6,7,8,9])).to eq(9)
    expect(Exercises.ex1([])).to eq(0)
  end

  it 'Returns the second element of an array' do
    expect(Exercises.ex2([9,8])).to eq(8)
    expect(Exercises.ex2([9,8])).to eq(8)
    expect(Exercises.ex2([9])).to eq(nil)
    expect(Exercises.ex2([10,9,8,7,6,5,4,3,2,1])).to eq(9)
  end

  it 'Returns the sum of the given array of numbers' do
    expect(Exercises.ex3([9,8])).to eq(17)
    expect(Exercises.ex3([9])).to eq(9)
    expect(Exercises.ex3([10,9,8,7,6,5,4,3,2,1])).to eq(55)
  end

  it 'Returns the max number of the given array' do
    expect(Exercises.ex4([])).to eq(nil)
    expect(Exercises.ex4([9])).to eq(9)
    expect(Exercises.ex4([10,9,8,7,88,6,5,4,15,3,2,1])).to eq(88)
  end
  
  it 'Iterates through an array and `puts` each element' do
    STDOUT.should_receive(:puts).with("string")
    STDOUT.should_receive(:puts).with('cheese')
    Exercises.ex5(["string", 'cheese'])
  end

  it "Updates the last item in the array to 'panda', already 'panda', updates to 'GODZILLA'" do
    expect(Exercises.ex6([])).to eq([])
    expect(Exercises.ex6([9,5,3,'string',8])).to eq([9,5,3,'string','panda'])
    expect(Exercises.ex6([9,5,3,'string',8,'panda'])).to eq([9,5,3,'string',8,'GODZILLA'])
  end

  it "If the string `str` exists in the array add `str` to the end of the array" do
    expect(Exercises.ex7([], 'john')).to eq([])
    expect(Exercises.ex7([9,5,3,'john',8], 'john')).to eq([9,5,3,'john', 8, 'john'])
    expect(Exercises.ex7([9,'dan',3,'str'], 'notdan')).to eq([9,'dan',3,'str'])
  end

  it '`People` is an array of hashes. Iterate through `people` and print out their name and occupation.' do
    STDOUT.should_receive(:puts).with("Bob Builder")
    STDOUT.should_receive(:puts).with("Mike Welder")
    Exercises.ex8([{ :name => 'Bob', :occupation => 'Builder' }, { :name => 'Mike', :occupation => 'Welder' }])
  end

  it "Returns `true` if the given time is in a leap year. Otherwise, returns `false`" do
    expect(Exercises.ex9(2012)).to eq(true)
    expect(Exercises.ex9(2000)).to eq(true)
    expect(Exercises.ex9(1900)).to eq(false)
    expect(Exercises.ex9(2016)).to eq(true)
    expect(Exercises.ex9(2014)).to eq(false)
    expect(Exercises.ex9(2100)).to eq(false)
    expect(Exercises.ex9(4000)).to eq(true)
  end

  it "Returns 'happy hour' if it is between 4 and 6pm and 'normal prices' otherwise" do
    expect(Exercises.ex10(Time.new(2014,8,31, 17,30,0, "+09:00"))).to eq('happy hour')
    expect(Exercises.ex10(Time.new(2014,8,31, 18,00,0, "+09:00"))).to eq('normal prices')
    expect(Exercises.ex10(Time.new(2014,8,31, 15,59,59, "+09:00"))).to eq('normal prices')
    expect(Exercises.ex10(Time.new(2014,8,31, 16,00,0, "+09:00"))).to eq('happy hour')
  end

end