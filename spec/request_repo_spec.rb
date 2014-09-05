require_relative 'spec_helper.rb'

describe PuppyBreeder::Repos::Requests do
  before(:each) {PuppyBreeder::Repos::Requests.new.destroy}
  before(:each) {PuppyBreeder::Repos::Puppies.new.destroy}

  describe '.log' do
    it 'returns an array of request objects' do
      requests = PuppyBreeder::Repos::Requests.new
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
    it "adds a new purchase request to the database" do
      requests = PuppyBreeder::Repos::Requests.new
      puppies = PuppyBreeder::Repos::Puppies.new
      request1 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      request2 = PuppyBreeder::PurchaseRequest.new("Pitbull")
      
      requests.add_request(request1)
      requests.add_request(request2)
      
      result = requests.log

      expect(result.size).to eq 2
      expect(result.first.breed).to eq("Golden Retriever")
    end

    it "checks if there is a puppy of the chosen breed available and marks as on_hold if not" do
      requests = PuppyBreeder::Repos::Requests.new
      puppies = PuppyBreeder::Repos::Puppies.new
      request1 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      
      requests.add_request(request1)
      
      result = requests.log

      expect(result.first.status).to eq (:on_hold)
    end
  end

  describe '.pending_requests' do
    it "shows all pending purchase requests" do
      requests = PuppyBreeder::Repos::Requests.new
      puppies = PuppyBreeder::Repos::Puppies.new
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
      requests = PuppyBreeder::Repos::Requests.new
      puppies = PuppyBreeder::Repos::Puppies.new
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
      requests = PuppyBreeder::Repos::Requests.new
      puppies = PuppyBreeder::Repos::Puppies.new
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

  # describe '#complete_request' do
  #   xit "changes the status of the accepted order to completed in the purchase orders array" do
  #     request1 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
  #     request2 = PuppyBreeder::PurchaseRequest.new("Pitbull")

  #     request1.accept

  #     result = PuppyBreeder::Repos::Requests.purchase_orders

  #     expect(result.first.status).to eq(:completed)
  #   end
  # end

  describe '#completed_purchase_orders' do
    xit "shows only purchase orders with a status of completed" do
      request1 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      request2 = PuppyBreeder::PurchaseRequest.new("Pitbull")

      request1.accept

      result = PuppyBreeder::Repos::Requests.completed_purchase_orders

      expect(result.size).to eq 1
      expect(result.first.status).to eq (:completed)
    end
  end

  describe '#hold_to_pending' do
    xit "changes the first on hold order for a particular breed to pending" do
      
    end
  end

end