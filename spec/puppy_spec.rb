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
		@store = Store.new
	  @blake = Puppy.new("Blake", 3, "collie")
	  @icy = Puppy.new("Icy", 9, "samoyed")
	  @dot = Puppy.new("Dotcom", 5, "wolf")
	  @pup1 = @store.amk.add_new_puppy("Blake", 3, "collie")
	  @pup2 = @store.amk.add_new_puppy("Icy", 9, "samoyed")
	  @pup3 = @store.amk.add_new_puppy("Dotcom", 5, "wolf")
	end

	it "show if breed desired is present" do
		@store.add_request("Bob", "collie")
		x = @store.puppy_available("collie")
		expect(x.count).to eq (1)
	end

	it "shows list of requests with status" do
		@store.add_request("Bob", "collie")
		@store.add_request("Stacy", "collie")
		expect(@store.amk.puppies.count).to eq (3)
		expect(@store.requests.count).to eq(2)
	end

	it "confirm true/false if breed is available" do
		@store.add_request("Bob","collie")
		expect(@store.amk.puppy_available?("collie")).to eq (true)
		expect(@store.amk.puppy_available?("samoyed")).to eq (false)
	end

	it "find purchase request and change status to accept (if pending)" do
		@store.add_request("Joey","samoyed")
		x = @store.requests[0].id
		expect(@store.change_purchase_request_status(x)).to eq (true)
	end

end


describe Request do
	before do
		store = Store.new
	  blake = Puppy.new("Blake", 3, "collie")
	  icy = Puppy.new("Icy", 9, "samoyed")
	  com = Puppy.new("Dotcom", 5, "wolf")
	end

	it "create a purchase request for customer and status is pending" do
		bob = Request.new("Bob", "collie")
		expect(bob.status).to eq ("pending")
	end
end