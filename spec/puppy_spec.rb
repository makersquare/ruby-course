require 'pry-byebug'
require "./puppy.rb"


describe Puppy do
  describe ".initialize" do
    it "creates a new puppy with name, age, and breed" do
      spot = Puppy.new("Spot", 20, "Doberman Pinscher")
      
      name = spot.name
      expect(name).to eq("Spot")

      age = spot.age
      expect(age).to eq(20)

      breed = spot.breed
      expect(breed).to eq(:dobermanpinscher)
    end
  end
end

describe Request do
  describe ".initialize" do
    it "creates a new request with customer and breed" do
      x = Request.new("Mrs. Robinson", "Poodle")

      name = x.customer
      expect(name).to eq("Mrs. Robinson")

      breed = x.breed
      expect(breed).to eq(:poodle)
    end

    it "initializes a new request with nil status and nil puppy" do
      x = Request.new("Mrs. Robinson", "Poodle")

      status = x.status
      expect(status).to be_nil

      puppy = x.puppy
      expect(puppy).to be_nil   
    end

    it "initializes a new request with the price from an array" do
      x = Request.new("Mrs. Robinson", "Poodle")

      price = x.price
      expect(price).to eq(1500)
    end
  end
end

describe PuppyMill do
  before do
    PuppyMill.add_puppy("Spot", 20, "Doberman Pinscher")
    @puppyarray = PuppyMill.add_puppy("Fluffy", 15, "Chihuahua")
    @spot = @puppyarray.first
    @fuffy = @puppyarray[1]
  end

  describe ".add_puppy" do
    it "creates a puppy and adds it to the puppy list array" do
      expect(@puppyarray).to be_an_instance_of(Array)
      expect(@puppyarray.length).to eq(2)
      expect(@spot).to be_an_instance_of(Puppy)
    end
  end
end

describe PuppyStore do
  before do
    PuppyStore.add_request("Coach Pop", "American Bulldog")
    @requestarray = PuppyStore.add_request("Patty Mills", "Dingo")
    @pop = @requestarray.first
    @patty = @requestarray[1]
  end

  describe ".add_puppy" do
    it "creates a request and adds it to the request list array" do
      expect(@requestarray).to be_an_instance_of(Array)
      expect(@requestarray.length).to eq(2)
      expect(@pop).to be_an_instance_of(Request)
    end
  end

  describe ".accept" do
    it "changes the status of the request to :accept" do
      PuppyStore.accept(@pop)
      result = @pop.status
      expect(result).to eq(:accept)
    end
  end

  describe ".deny" do
    it "changes the status of the request to :deny" do
      PuppyStore.deny(@patty)
      result = @patty.status
      expect(result).to eq(:deny)
    end
  end
end