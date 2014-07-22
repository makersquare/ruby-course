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

  describe ".sell" do
    before do
      @puppyarray = PuppyMill.add_puppy("Obadiah", 14, "American Bulldog")
      @obadiah = @puppyarray.last
      PuppyStore.sell(@obadiah ,@pop)
    end

    it "records the sale of a puppy by changing status variables of the request" do
      expect(@pop.status).to eq(:sold)
    end

    it "records the puppy sold in the puppy variable of the request" do
      expect(@pop.puppy).to eq(@obadiah)
    end

    it "deletes the puppy from the array of available puppies" do
      answer = @puppyarray.include?(@obadiah)
      expect(answer).to be false
    end
  end

  describe ".view_accepted_orders" do

    before do
      @tim = PuppyStore.add_request("Tim Duncan", "Chihuhua").last
      PuppyStore.accept(@tim)    
    end
    
    it "returns an array of requests that were accepted" do
      accepted_orders = PuppyStore.view_accepted_orders
      expect(accepted_orders).to be_an_instance_of(Array)
      expect(accepted_orders).to include(@tim) #accepted on line 128
    end

    it "returns an array that doesn't include other orders" do
      accepted_orders = PuppyStore.view_accepted_orders
      answer = accepted_orders.include?(@pop) #sold on line 107
      expect(answer).to be false
    end
  end

  describe ".view_denied_orders" do
    it "returns an array of requests that were denied" do
      denied_orders = PuppyStore.view_denied_orders
      expect(denied_orders).to be_an_instance_of(Array)
      expect(denied_orders).to include(@patty) #denied on line 97
    end

    it "returns an array that doesn't include other orders" do
      denied_orders = PuppyStore.view_denied_orders
      answer = denied_orders.include?(@pop)
      expect(answer).to be false
    end
  end
  
  describe ".view_pending_orders" do
    

  end
  
  describe ".view_completed_orders" do
  end

end