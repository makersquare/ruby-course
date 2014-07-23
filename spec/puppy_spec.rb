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

	it "allows killing/deletion of a puppy from puppy database" do
		amk = PuppyGarden.new
		amk.add_new_puppy("jj", 4, "collie")
		amk.add_new_puppy("wally", 9, "cat")
		amk.kill_puppy
		expect(amk.puppies.count).to eq (1)
	end
end

describe Store do
	it "starts with empty request and completed request list" do
		store = Store.new
		expect(store.requests.count).to eq (0)
	end

	it "add a request to request list" do
		store = Store.new
		store.add_request("Bob", "collie")
		expect(store.requests.count).to eq (1)
	end


end

describe Store do
	before do
		store = Store.new
	  blake = Puppy.new("Blake", 3, "collie")
	  icy = Puppy.new("Icy", 9, "samoyed")
	  dot = Puppy.new("Dotcom", 5, "wolf")
	  amk = PuppyGarden.new
	  pup1 = amk.add_new_puppy("Blake", 3, "collie")
	  pup2 = amk.add_new_puppy("Icy", 9, "samoyed")
	  pup3 = amk.add_new_puppy("Dotcom", 5, "wolf")
	end

	it "has customer name, and breed desired" do
		# req1 = Request.new("Bob", "collie")
		store = Store.new
		store.add_request("Bob", "collie")
		x = store.puppy_available("collie")
		expect(x.count).to eq (1)
	end

	xit "shows list of requests with status" do
		store = Store.new
		store.add_request("Bob", "collie")
		store.add_request("Stacy", "collie")
	end
end


describe Request do
	before do
		store = Store.new
	  blake = Puppy.new("Blake", 3, "collie")
	  icy = Puppy.new("Icy", 9, "samoyed")
	  com = Puppy.new("Dotcom", 5, "wolf")
	end

	it "create a purchase request for customer" do
		bob = Request.new("Bob", "collie")
	end
end