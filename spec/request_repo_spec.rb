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

  # describe '#complete_request' do
  #   xit "changes the status of the accepted order to completed in the purchase orders array" do
  #     request1 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
  #     request2 = PuppyBreeder::PurchaseRequest.new("Pitbull")

  #     request1.accept

  #     result = PuppyBreeder::Repos::Requests.purchase_orders

  #     expect(result.first.status).to eq(:completed)
  #   end
  # end

  # describe '#completed_purchase_orders' do
  #   xit "shows only purchase orders with a status of completed" do
  #     request1 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
  #     request2 = PuppyBreeder::PurchaseRequest.new("Pitbull")

  #     request1.accept

  #     result = PuppyBreeder::Repos::Requests.completed_purchase_orders

  #     expect(result.size).to eq 1
  #     expect(result.first.status).to eq (:completed)
  #   end
  # end

  # describe '#hold_to_pending' do
  #   xit "changes the first on hold order for a particular breed to pending" do
      
  #   end
  # end

end