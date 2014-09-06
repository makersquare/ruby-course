require_relative 'spec_helper.rb'

describe PuppyBreeder::Repos::Requests do
  before(:each) {PuppyBreeder.request_repo.destroy_and_rebuild}
  before(:each) {PuppyBreeder.puppy_repo.destroy_and_rebuild}

  describe '.log' do
    it 'returns an array of request objects' do
      requests = PuppyBreeder.request_repo
      result = requests.log

      expect(result).to eq ([])

      request1 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      requests.add_request(request1)
      result = requests.log

      expect(result.size).to eq 1
      expect(result.first.class).to eq(PuppyBreeder::PurchaseRequest)
    end 
  end

  describe '.add_request' do
    it "adds a new purchase request to the database and sets the id attribute" do
      requests = PuppyBreeder.request_repo
      puppies = PuppyBreeder.puppy_repo
      request1 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      request2 = PuppyBreeder::PurchaseRequest.new("Pitbull")
      
      requests.add_request(request1)
      requests.add_request(request2)
      
      result = requests.log

      expect(result.size).to eq 2
      expect(result.first.breed).to eq("Golden Retriever")
      expect(result.first.id.to_i).to eq 1
    end

    it "checks if there is a puppy of the chosen breed available and marks as on_hold if not" do
      requests = PuppyBreeder.request_repo
      puppies = PuppyBreeder.puppy_repo
      request1 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      
      requests.add_request(request1)
      
      result = requests.log

      expect(result.first.status).to eq (:on_hold)
    end
  end

  describe '.pending_requests' do
    it "shows all pending purchase requests" do
      requests = PuppyBreeder.request_repo
      puppies = PuppyBreeder.puppy_repo
      request1 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      request2 = PuppyBreeder::PurchaseRequest.new("Pitbull") 
      spot = PuppyBreeder::Puppy.new("Spot", 1, "Golden Retriever")
      puppies.add_puppy(spot)    

      requests.add_request(request1)
      requests.add_request(request2)

      result = requests.pending_requests

      expect(result.size).to eq 1
      expect(result.first.status).to eq(:pending)
    end
  end

  describe '.completed_requests' do
    it "shows all completed purchase requests" do
      requests = PuppyBreeder.request_repo
      puppies = PuppyBreeder.puppy_repo
      request1 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      request2 = PuppyBreeder::PurchaseRequest.new("Pitbull") 
      spot = PuppyBreeder::Puppy.new("Spot", 1, "Golden Retriever")
      puppies.add_puppy(spot)
      request1.accept!    

      requests.add_request(request1)
      requests.add_request(request2)

      result = requests.completed_requests

      expect(result.size).to eq 1
      expect(result.first.status).to eq(:completed)
    end
  end

  describe '.hold_requests' do
    it "shows all on_hold purchase requests" do
      requests = PuppyBreeder.request_repo
      puppies = PuppyBreeder.puppy_repo
      request1 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      request2 = PuppyBreeder::PurchaseRequest.new("Pitbull") 
      spot = PuppyBreeder::Puppy.new("Spot", 1, "Golden Retriever")
      puppies.add_puppy(spot)    

      requests.add_request(request1)
      requests.add_request(request2)

      result = requests.hold_requests

      expect(result.size).to eq 1
      expect(result.first.status).to eq(:on_hold)
    end
  end

  describe 'update_request_status' do
    it "changes the status in the database to the new status" do
      requests = PuppyBreeder.request_repo
      puppies = PuppyBreeder.puppy_repo
      request1 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      request2 = PuppyBreeder::PurchaseRequest.new("Pitbull") 

      requests.add_request(request1)
      requests.add_request(request2)

      spot = PuppyBreeder::Puppy.new("Spot", 1, "Golden Retriever")
      puppies.add_puppy(spot)
      request1.accept! 
      requests.update_request_status(request1)  

      result = requests.log

      expect(result.first.status).to eq(:completed)
      expect(result.last.status).to eq(:on_hold)
    end
  end

  describe '.update_holds' do
    it "checks all on hold orders to see if a puppy has been added with that breed and updates the first" do
      requests = PuppyBreeder.request_repo
      puppies = PuppyBreeder.puppy_repo
      request1 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      request2 = PuppyBreeder::PurchaseRequest.new("Pitbull") 

      requests.add_request(request1)
      requests.add_request(request2)

      spot = PuppyBreeder::Puppy.new("Spot", 1, "Golden Retriever")
      puppies.add_puppy(spot)

      requests.update_holds
      
      result = requests.log
      
      expect(result.first.status).to eq :pending
      expect(result.last.status).to eq :on_hold
    end
  end

end