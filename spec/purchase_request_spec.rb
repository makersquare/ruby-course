require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do
  before(:each) {PuppyBreeder.puppy_repo.destroy}
  
  describe '.initialize' do
    it "creates a new purchase request for a breed with a status of pending" do
      spot = PuppyBreeder::Puppy.new("Spot", 1, "Golden Retriever")
      puppies = PuppyBreeder.puppy_repo
      puppies.add_puppy(spot)
      request = PuppyBreeder::PurchaseRequest.new("Golden Retriever")

      expect(request.breed).to eq("Golden Retriever")
      expect(request.status).to eq(:pending)
    end

    it "sets the id number as nil for each purchase request" do
      request1 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      request2 = PuppyBreeder::PurchaseRequest.new("Pitbull")

      request1.id.should be_nil
    end
  end

  describe '.accept!' do
    it "changes the purchase request status from pending to completed" do
      request = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      request.accept!

      expect(request.status).to eq(:completed)
    end
  end

  describe '.on_hold!' do
    it "changes the purchase request status from pending to on_hold" do
      request = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      request.on_hold!

      expect(request.status).to eq(:on_hold)
    end
  end

end





