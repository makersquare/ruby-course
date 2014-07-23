require 'pry-byebug'
require "./puppy.rb"


describe Puppy do
  describe ".initialize" do
    it "creates a new puppy with name, age, and breed" do
      spot = Puppy.new("Spot", 20, :dobermanpinscher)
      
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
      x = Request.new("Mrs. Robinson", :poodle)

      name = x.customer
      expect(name).to eq("Mrs. Robinson")

      breed = x.breed
      expect(breed).to eq(:poodle)
    end

    it "initializes a new request with :pending status and nil puppy" do
      x = Request.new("Mrs. Robinson", "Poodle")

      status = x.status
      expect(status).to eq(:pending)

      puppy = x.puppy
      expect(puppy).to be_nil   
    end

    it "initializes a new request with the price from an array" do
      x = Request.new("Mrs. Robinson", :poodle)

      price = x.price
      expect(price).to eq(1500)
    end
  end
end

describe PuppyMill do
  before do
    @spot = PuppyMill.add_puppy("Spot", 20, "Doberman Pinscher").first
    @fluffy = PuppyMill.add_puppy("Fluffy", 15, "Chihuahua").first
  end

  describe ".add_puppy" do
    it "creates a puppy and adds it to the puppy list array" do
      expect(PuppyMill.avail_puppies).to be_an_instance_of(Hash)
      expect(PuppyMill.avail_puppies.length).to eq(2)
      expect(@spot).to be_an_instance_of(Puppy)
    end
  end

  before do
    PuppyMill.add_request("Coach Pop", "American Bulldog")
    @requestarray = PuppyMill.add_request("Patty Mills", "Dingo")
    @pop = @requestarray.first
    @patty = @requestarray[1]
  end

  describe ".add_request" do
    it "creates a request and adds it to the request list array" do
      expect(@requestarray).to be_an_instance_of(Array)
      expect(@pop).to be_an_instance_of(Request)
    end
  end

  describe ".accept" do
    it "changes the status of the request to :accept" do
      PuppyMill.accept(@pop)
      result = @pop.status
      expect(result).to eq(:accept)
    end
  end

  describe ".deny" do
    it "changes the status of the request to :deny" do
      PuppyMill.deny(@patty)
      result = @patty.status
      expect(result).to eq(:deny)
    end
  end

  describe ".sell" do
    before do
      @obadiah = PuppyMill.add_puppy("Obadiah", 14, "American Bulldog").first
      PuppyMill.sell(@obadiah ,@pop)
    end

    it "records the sale of a puppy by changing status variables of the request" do
      expect(@pop.status).to eq(:sold)
    end

    it "records the puppy sold in the puppy variable of the request" do
      expect(@pop.puppy).to eq(@obadiah)
    end

    it "deletes the puppy from the hash of available puppies" do
      answer = PuppyMill.avail_puppies[:americanbulldog].include?(@obadiah)
      expect(answer).to be false
    end
  end

  describe ".view_accepted_orders" do
    it "returns an array of requests that were accepted" do
      tim = PuppyMill.add_request("Tim Duncan", "Chihuhua").last 
      PuppyMill.accept(tim)  
      ginobili = PuppyMill.add_request("Manu Ginobili", "American Bulldog").last 
      bellinelli = PuppyMill.add_request("Marco Bellinelli", "Poodle").last
      PuppyMill.sell(@spot, bellinelli)
      kawhi = PuppyMill.add_request("Kawhi Leonard", "Doberman Pinscher").last
      PuppyMill.deny(kawhi)

      accepted_orders = PuppyMill.view_accepted_orders
      expect(accepted_orders).to be_an_instance_of(Array)
      expect(accepted_orders).to include(tim) 
    end

    it "returns an array that doesn't include other orders" do
      tim = PuppyMill.add_request("Tim Duncan", "Chihuhua").last 
      PuppyMill.accept(tim)  
      ginobili = PuppyMill.add_request("Manu Ginobili", "American Bulldog").last 
      bellinelli = PuppyMill.add_request("Marco Bellinelli", "Poodle").last
      PuppyMill.sell(@spot, bellinelli)
      kawhi = PuppyMill.add_request("Kawhi Leonard", "Doberman Pinscher").last
      PuppyMill.deny(kawhi)

      accepted_orders = PuppyMill.view_accepted_orders
      answer = accepted_orders.include?(kawhi) 
      expect(answer).to be false
    end
  end

  describe ".view_denied_orders" do
    it "returns an array of requests that were denied" do
      tim = PuppyMill.add_request("Tim Duncan", "Chihuhua").last 
      PuppyMill.accept(tim)  
      ginobili = PuppyMill.add_request("Manu Ginobili", "American Bulldog").last 
      bellinelli = PuppyMill.add_request("Marco Bellinelli", "Poodle").last
      PuppyMill.sell(@spot, bellinelli)
      kawhi = PuppyMill.add_request("Kawhi Leonard", "Doberman Pinscher").last
      PuppyMill.deny(kawhi)

      denied_orders = PuppyMill.view_denied_orders
      expect(denied_orders).to be_an_instance_of(Array)
      expect(denied_orders).to include(kawhi) 
    end

    it "returns an array that doesn't include other orders" do
      tim = PuppyMill.add_request("Tim Duncan", "Chihuhua").last 
      PuppyMill.accept(tim)  
      ginobili = PuppyMill.add_request("Manu Ginobili", "American Bulldog").last 
      bellinelli = PuppyMill.add_request("Marco Bellinelli", "Poodle").last
      PuppyMill.sell(@spot, bellinelli)
      kawhi = PuppyMill.add_request("Kawhi Leonard", "Doberman Pinscher").last
      PuppyMill.deny(kawhi)

      denied_orders = PuppyMill.view_denied_orders
      answer = denied_orders.include?(ginobili)
      expect(answer).to be false
    end
  end
  
  describe ".view_pending_orders" do
    it "returns an array of requests that are pending" do
      tim = PuppyMill.add_request("Tim Duncan", "Chihuhua").last 
      PuppyMill.accept(tim)  
      bully = PuppyMill.add_puppy("SuperStar", 60, "american bulldog")
      ginobili = PuppyMill.add_request("Manu Ginobili", "American Bulldog").last 
      bellinelli = PuppyMill.add_request("Marco Bellinelli", "Poodle").last
      PuppyMill.sell(@spot, bellinelli)
      kawhi = PuppyMill.add_request("Kawhi Leonard", "Doberman Pinscher").last
      PuppyMill.deny(kawhi)

      pending_orders = PuppyMill.view_pending_orders
      expect(pending_orders).to be_an_instance_of(Array)
      expect(pending_orders).to include(ginobili) 
    end

    it "returns an array that doesn't include other orders" do
      tim = PuppyMill.add_request("Tim Duncan", "Chihuhua").last 
      PuppyMill.accept(tim)  
      ginobili = PuppyMill.add_request("Manu Ginobili", "American Bulldog").last 
      bellinelli = PuppyMill.add_request("Marco Bellinelli", "Poodle").last
      PuppyMill.sell(@spot, bellinelli)
      kawhi = PuppyMill.add_request("Kawhi Leonard", "Doberman Pinscher").last
      PuppyMill.deny(kawhi)

      pending_orders = PuppyMill.view_pending_orders
      answer = pending_orders.include?(tim) 
      expect(answer).to be false
    end
  end
  
  describe ".view_completed_orders" do
    it "returns an array of requests that are completed" do
      tim = PuppyMill.add_request("Tim Duncan", "Chihuhua").last 
      PuppyMill.accept(tim)  
      ginobili = PuppyMill.add_request("Manu Ginobili", "American Bulldog").last 
      bellinelli = PuppyMill.add_request("Marco Bellinelli", "Poodle").last
      PuppyMill.sell(@spot, bellinelli)
      kawhi = PuppyMill.add_request("Kawhi Leonard", "Doberman Pinscher").last
      PuppyMill.deny(kawhi)

      completed_orders = PuppyMill.view_completed_orders
      expect(completed_orders).to be_an_instance_of(Array)
      expect(completed_orders).to include(bellinelli)
    end

    it "returns an array that doesn't include other orders" do
      tim = PuppyMill.add_request("Tim Duncan", "Chihuhua").last 
      PuppyMill.accept(tim)  
      ginobili = PuppyMill.add_request("Manu Ginobili", "American Bulldog").last 
      bellinelli = PuppyMill.add_request("Marco Bellinelli", "Poodle").last
      PuppyMill.sell(@spot, bellinelli)
      kawhi = PuppyMill.add_request("Kawhi Leonard", "Doberman Pinscher").last
      PuppyMill.deny(kawhi)

      completed_orders = PuppyMill.view_completed_orders
      answer = completed_orders.include?(tim) 
      expect(answer).to be false
    end
  end
end