require 'pry-byebug'
require './puppy.rb'

describe Puppy do
  it "has a name, age, and breed" do
    pup = Puppy.new("Oodle", 1, "poodle")
    expect(pup.name).to eq "Oodle"
    expect(pup.age).to eq 1
    expect(pup.breed).to eq "poodle"
  end

  it "has a default breed of german shepherd" do
    pup = Puppy.new("Hans", 30)
    expect(pup.breed).to eq "german shepherd"
  end
end

describe PuppyGarden do
	it "has a name and empty record of dogs" do
		amk = PuppyGarden.new
		expect(amk.puppies.count).to eq (0)
	end

	it "allows adding of a new puppy" do
		amk = PuppyGarden.new
		amk.add_new_puppy("jj", 4, "collie")
		expect(amk.puppies.count).to eq (1)
		expect(amk.puppies.class).to eq (Array)
	end

	it "allows killing/delition of a puppy" do
		amk = PuppyGarden.new
		amk.add_new_puppy("jj", 4, "collie")
		amk.add_new_puppy("wally", 9, "cat")
		amk.kill_puppy("wally", 9, "cat")
		expect(amk.puppies.count).to eq (1)
	end

end