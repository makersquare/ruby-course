require 'pry-byebug'
require "./puppy_app.rb"


describe Puppy do
  describe ".initialize" do
    it "creates a new puppy with name, dob, and breed" do
      spot = Puppy.new("Spot", "June 26, 2014", :dobermanpinscher, 5)
      
      name = spot.name
      expect(name).to eq("Spot")

      dob = spot.dob
      expect(dob).to eq("June 26, 2014")

      breed = spot.breed
      expect(breed).to eq(:dobermanpinscher)
    end
  end
end

describe Request do
  describe ".initialize" do
    it "creates a new request with customer and breed" do
      x = Request.new("Mrs. Robinson", :poodle, 5, "June26")

      name = x.customer
      expect(name).to eq("Mrs. Robinson")

      breed = x.breed
      expect(breed).to eq(:poodle)
    end

    it "initializes a new request with :pending status and nil puppy" do
      x = Request.new("Mrs. Robinson", :poodle, 5, "June26")

      status = x.status
      expect(status).to eq(:pending)

      puppy = x.puppy
      expect(puppy).to be_nil   
    end

  end
end

describe PuppyMill do
  # before do
  #end

  describe ".add_puppy" do
    it "creates a puppy and adds it to the puppy list hash" do
      expect(PuppyMill.avail_puppies).to be_an_instance_of(Hash)
      hershey = Puppy.new("Hershey", 55, :chocolatelab, 12)
      PuppyMill.add_puppy(hershey)
      expect(hershey).to be_an_instance_of(Puppy)
      expect(PuppyMill.avail_puppies[:chocolatelab]).to include(hershey)
    end

    it "checks orders on hold to see if anyone is waiting for a puppy of this breed" do
      sean = Request.new("Sean", :chowchow, 5, 5)
      shana = Request.new("Shana", :chowchow, 5, 5)
      PuppyMill.add_request(sean)
      PuppyMill.add_request(shana)

      expect(sean.status).to eq(:hold)
      expect(shana.status).to eq(:hold)

      sukhoi = Puppy.new("Sukhoi", 100, :chowchow, 13)
      PuppyMill.add_puppy(sukhoi)
    
      expect(sean.status).to eq(:pending)
      expect(shana.status).to eq(:pending)

      expect(PuppyMill.all_requests[:hold]).to_not include(shana)
      expect(PuppyMill.all_requests[:hold]).to_not include(sean)
      expect(PuppyMill.all_requests[:pending]).to include(sean && shana)
    end
  end

  before do
    @pop = Request.new("Coach Pop", "American Bulldog", 6, 18)
    PuppyMill.add_request(@pop)
    @patty = Request.new("Patty Mills", "Dingo", 7, 2014)
    PuppyMill.add_request(@patty)
  end

  describe ".add_request" do
    it "creates a request and adds it to the request list array" do
      expect(PuppyMill.all_requests).to be_an_instance_of(Hash)
      expect(@pop).to be_an_instance_of(Request)
    end

    it "automatically assigns a status of :pending if a dog is available" do
      spot = Puppy.new("Spot", 20, :dobermanpinscher, 4)
      PuppyMill.add_puppy(spot)
      fluffy = Puppy.new("Fluffy", 15, :chihuahua, 10)
      PuppyMill.add_puppy(fluffy)
      this_request = Request.new("Tiago Splitter", :chihuahua, 5, 6)
      PuppyMill.add_request(this_request)
      expect(this_request.status).to eq(:pending)
    end

    it "puts :pending requests into the correct section of the hash" do
      spot = Puppy.new("Spot", 20, :dobermanpinscher, 4)
      PuppyMill.add_puppy(spot)
      fluffy = Puppy.new("Fluffy", 15, :chihuahua, 10)
      PuppyMill.add_puppy(fluffy)

      this_request = Request.new("Tiago Splitter", :chihuahua, 5, 6)
      PuppyMill.add_request(this_request)      
      expect(PuppyMill.all_requests[:pending]).to include(this_request)
      expect(PuppyMill.all_requests[:hold]).not_to include(this_request)
      expect(PuppyMill.all_requests[:sold]).not_to include(this_request)
      expect(PuppyMill.all_requests[:accept]).not_to include(this_request)
      expect(PuppyMill.all_requests[:deny]).not_to include(this_request)
    end

    it "automatically assign a status of :hold if a dog is not available" do
      expect(@patty.status).to eq(:hold)
    end

    it "puts :hold requests into the correct section of the hash" do
      this_request = Request.new("Tiago Splitter", :chihuahua, 5, 6)
      PuppyMill.add_request(this_request)      
      expect(PuppyMill.all_requests[:hold]).to include(@patty)
      expect(PuppyMill.all_requests[:pending]).not_to include(@patty)
      expect(PuppyMill.all_requests[:sold]).not_to include(@patty)
      expect(PuppyMill.all_requests[:accept]).not_to include(@patty)
      expect(PuppyMill.all_requests[:deny]).not_to include(@patty)
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
      @obadiah = Puppy.new("Obadiah", 14, :americanbulldog, 5)
      PuppyMill.add_puppy(@obadiah)
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

  describe ".view_hold_orders" do
    it "returns an array of requests that are on hold" do
      spot = Puppy.new("Spot", 20, :dobermanpinscher, 4)
      PuppyMill.add_puppy(spot)
      fluffy = Puppy.new("Fluffy", 15, :chihuahua, 10)
      PuppyMill.add_puppy(fluffy)

      tim = Request.new("Tim Duncan", :chihuahua, 5, 5)
      PuppyMill.add_request(tim)
      PuppyMill.accept(tim)  
      ginobili = Request.new("Manu Ginobili", :americanbulldog, 5, 5)
      PuppyMill.add_request(ginobili)
      bellinelli = Request.new("Marco Bellinelli", :poodle, 5, 5)
      PuppyMill.add_request(bellinelli)
      PuppyMill.sell(spot, bellinelli)
      kawhi = Request.new("Kawhi Leonard", :dobermanpinscher, 5, 5)
      PuppyMill.add_request(kawhi)
      PuppyMill.deny(kawhi)

      expect(PuppyMill.view_hold_orders).to be_an_instance_of(Array)
      expect(PuppyMill.view_hold_orders).to include(ginobili) 
    end

    it "returns an array that doesn't include other orders" do
      spot = Puppy.new("Spot", 20, :dobermanpinscher, 4)
      PuppyMill.add_puppy(spot)
      fluffy = Puppy.new("Fluffy", 15, :chihuahua, 10)
      PuppyMill.add_puppy(fluffy)

      tim = Request.new("Tim Duncan", :chihuahua, 5, 5)
      PuppyMill.add_request(tim)
      PuppyMill.accept(tim)  
      ginobili = Request.new("Manu Ginobili", :americanbulldog, 5, 5)
      PuppyMill.add_request(ginobili)
      bellinelli = Request.new("Marco Bellinelli", :poodle, 5, 5)
      PuppyMill.add_request(bellinelli)
      PuppyMill.sell(spot, bellinelli)
      kawhi = Request.new("Kawhi Leonard", :dobermanpinscher, 5, 5)
      PuppyMill.add_request(kawhi)
      PuppyMill.deny(kawhi)

      expect(PuppyMill.view_hold_orders).to_not include(kawhi && bellinelli && tim)
    end
  end

  describe ".view_accepted_orders" do
    it "returns an array of requests that were accepted" do
      spot = Puppy.new("Spot", 20, :dobermanpinscher, 4)
      PuppyMill.add_puppy(spot)
      fluffy = Puppy.new("Fluffy", 15, :chihuahua, 10)
      PuppyMill.add_puppy(fluffy)
      
      tim = Request.new("Tim Duncan", :chihuahua, 5, 5)
      PuppyMill.add_request(tim)
      PuppyMill.accept(tim)  
      ginobili = Request.new("Manu Ginobili", :americanbulldog, 5, 5)
      PuppyMill.add_request(ginobili)
      bellinelli = Request.new("Marco Bellinelli", :poodle, 5, 5)
      PuppyMill.add_request(bellinelli)
      PuppyMill.sell(spot, bellinelli)
      kawhi = Request.new("Kawhi Leonard", :dobermanpinscher, 5, 5)
      PuppyMill.add_request(kawhi)
      PuppyMill.deny(kawhi)

      accepted_orders = PuppyMill.view_accepted_orders
      expect(accepted_orders).to be_an_instance_of(Array)
      expect(accepted_orders).to include(tim) 
    end

    it "returns an array that doesn't include other orders" do
      spot = Puppy.new("Spot", 20, :dobermanpinscher, 4)
      PuppyMill.add_puppy(spot)
      fluffy = Puppy.new("Fluffy", 15, :chihuahua, 10)
      PuppyMill.add_puppy(fluffy)

      tim = Request.new("Tim Duncan", :chihuahua, 5, 5)
      PuppyMill.add_request(tim)
      PuppyMill.accept(tim)  
      ginobili = Request.new("Manu Ginobili", :americanbulldog, 5, 5)
      PuppyMill.add_request(ginobili)
      bellinelli = Request.new("Marco Bellinelli", :poodle, 5, 5)
      PuppyMill.add_request(bellinelli)
      PuppyMill.sell(spot, bellinelli)
      kawhi = Request.new("Kawhi Leonard", :dobermanpinscher, 5, 5)
      PuppyMill.add_request(kawhi)
      PuppyMill.deny(kawhi)

      accepted_orders = PuppyMill.view_accepted_orders
      answer = accepted_orders.include?(kawhi) 
      expect(answer).to be false
    end
  end

  describe ".view_denied_orders" do
    it "returns an array of requests that were denied" do
      spot = Puppy.new("Spot", 20, :dobermanpinscher, 4)
      PuppyMill.add_puppy(spot)
      fluffy = Puppy.new("Fluffy", 15, :chihuahua, 10)
      PuppyMill.add_puppy(fluffy)      

      tim = Request.new("Tim Duncan", :chihuahua, 5, 5)
      PuppyMill.add_request(tim)
      PuppyMill.accept(tim)  
      ginobili = Request.new("Manu Ginobili", :americanbulldog, 5, 5)
      PuppyMill.add_request(ginobili)
      bellinelli = Request.new("Marco Bellinelli", :poodle, 5, 5)
      PuppyMill.add_request(bellinelli)
      PuppyMill.sell(spot, bellinelli)
      kawhi = Request.new("Kawhi Leonard", :dobermanpinscher, 5, 5)
      PuppyMill.add_request(kawhi)
      PuppyMill.deny(kawhi)

      denied_orders = PuppyMill.view_denied_orders
      expect(denied_orders).to be_an_instance_of(Array)
      expect(denied_orders).to include(kawhi) 
    end

    it "returns an array that doesn't include other orders" do
      spot = Puppy.new("Spot", 20, :dobermanpinscher, 4)
      PuppyMill.add_puppy(spot)
      fluffy = Puppy.new("Fluffy", 15, :chihuahua, 10)
      PuppyMill.add_puppy(fluffy)

      tim = Request.new("Tim Duncan", :chihuahua, 5, 5)
      PuppyMill.add_request(tim)
      PuppyMill.accept(tim)  
      ginobili = Request.new("Manu Ginobili", :americanbulldog, 5, 5)
      PuppyMill.add_request(ginobili)
      bellinelli = Request.new("Marco Bellinelli", :poodle, 5, 5)
      PuppyMill.add_request(bellinelli)
      PuppyMill.sell(spot, bellinelli)
      kawhi = Request.new("Kawhi Leonard", :dobermanpinscher, 5, 5)
      PuppyMill.add_request(kawhi)
      PuppyMill.deny(kawhi)

      denied_orders = PuppyMill.view_denied_orders
      answer = denied_orders.include?(ginobili)
      expect(answer).to be false
    end
  end
  
  describe ".view_pending_orders" do
    it "returns an array of requests that are pending" do
      spot = Puppy.new("Spot", 20, :dobermanpinscher, 4)
      PuppyMill.add_puppy(spot)
      fluffy = Puppy.new("Fluffy", 15, :chihuahua, 10)
      PuppyMill.add_puppy(fluffy)

      tim = Request.new("Tim Duncan", :chihuahua, 5, 5)
      PuppyMill.add_request(tim)
      PuppyMill.accept(tim)  
      ginobili = Request.new("Manu Ginobili", :americanbulldog, 5, 5)
      PuppyMill.add_request(ginobili)
      bellinelli = Request.new("Marco Bellinelli", :poodle, 5, 5)
      PuppyMill.add_request(bellinelli)
      PuppyMill.sell(spot, bellinelli)
      kawhi = Request.new("Kawhi Leonard", :dobermanpinscher, 5, 5)
      PuppyMill.add_request(kawhi)
      PuppyMill.deny(kawhi)
      bully = Puppy.new("SuperStar", 60, :americanbulldog, 12)
      PuppyMill.add_puppy(bully)
      
      pending_orders = PuppyMill.view_pending_orders
      expect(pending_orders).to be_an_instance_of(Array)
      expect(pending_orders).to include(ginobili) 
    end

    it "returns an array that doesn't include other orders" do
      spot = Puppy.new("Spot", 20, :dobermanpinscher, 4)
      PuppyMill.add_puppy(spot)
      fluffy = Puppy.new("Fluffy", 15, :chihuahua, 10)
      PuppyMill.add_puppy(fluffy)

      tim = Request.new("Tim Duncan", :chihuahua, 5, 5)
      PuppyMill.add_request(tim)
      PuppyMill.accept(tim)  
      ginobili = Request.new("Manu Ginobili", :americanbulldog, 5, 5)
      PuppyMill.add_request(ginobili)
      bellinelli = Request.new("Marco Bellinelli", :poodle, 5, 5)
      PuppyMill.add_request(bellinelli)
      PuppyMill.sell(spot, bellinelli)
      kawhi = Request.new("Kawhi Leonard", :dobermanpinscher, 5, 5)
      PuppyMill.add_request(kawhi)
      PuppyMill.deny(kawhi)

      pending_orders = PuppyMill.view_pending_orders
      answer = pending_orders.include?(tim) 
      expect(answer).to be false
    end
  end
  
  describe ".view_completed_orders" do
    it "returns an array of requests that are completed" do
      spot = Puppy.new("Spot", 20, :dobermanpinscher, 4)
      PuppyMill.add_puppy(spot)
      fluffy = Puppy.new("Fluffy", 15, :chihuahua, 10)
      PuppyMill.add_puppy(fluffy)
      
      tim = Request.new("Tim Duncan", :chihuahua, 5, 5)
      PuppyMill.add_request(tim)
      PuppyMill.accept(tim)  
      ginobili = Request.new("Manu Ginobili", :americanbulldog, 5, 5)
      PuppyMill.add_request(ginobili)
      bellinelli = Request.new("Marco Bellinelli", :poodle, 5, 5)
      PuppyMill.add_request(bellinelli)
      PuppyMill.sell(spot, bellinelli)
      kawhi = Request.new("Kawhi Leonard", :dobermanpinscher, 5, 5)
      PuppyMill.add_request(kawhi)
      PuppyMill.deny(kawhi)

      completed_orders = PuppyMill.view_completed_orders
      expect(completed_orders).to be_an_instance_of(Array)
      expect(completed_orders).to include(bellinelli)
    end

    it "returns an array that doesn't include other orders" do
      spot = Puppy.new("Spot", 20, :dobermanpinscher, 4)
      PuppyMill.add_puppy(spot)
      fluffy = Puppy.new("Fluffy", 15, :chihuahua, 10)
      PuppyMill.add_puppy(fluffy)

      tim = Request.new("Tim Duncan", :chihuahua, 5, 5)
      PuppyMill.add_request(tim)
      PuppyMill.accept(tim)  
      ginobili = Request.new("Manu Ginobili", :americanbulldog, 5, 5)
      PuppyMill.add_request(ginobili)
      bellinelli = Request.new("Marco Bellinelli", :poodle, 5, 5)
      PuppyMill.add_request(bellinelli)
      PuppyMill.sell(spot, bellinelli)
      kawhi = Request.new("Kawhi Leonard", :dobermanpinscher, 5, 5)
      PuppyMill.add_request(kawhi)
      PuppyMill.deny(kawhi)

      completed_orders = PuppyMill.view_completed_orders
      answer = completed_orders.include?(tim) 
      expect(answer).to be false
    end
  end
end