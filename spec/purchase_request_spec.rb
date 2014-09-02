require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do
  describe '.initialize' do
    it "creates a new purchase request for a breed with a status of pending" do
      request = PuppyBreeder::PurchaseRequest.new("Golden Retriever")

      expect(request.breed).to eq("Golden Retriever")
      expect(request.status).to eq(:pending)
    end

    it "creates a unique id number for each purchase request" do
      request1 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      request2 = PuppyBreeder::PurchaseRequest.new("Pitbull")

      request1.id.should_not eq(request2.id)
    end
  end

  describe '.review' do
    xit "shows all pending purchase requests" do
      request1 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      request2 = PuppyBreeder::PurchaseRequest.new("Pitbull")

      result = PuppyBreeder::PurchaseRequest.review

      expect(result.first).to be_a(PurchaseRequest)
    end
  end

  describe '.accept' do
    it "changes the purchase request status from pending to completed" do
      request = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      request.accept

      expect(request.status).to eq(:completed)
    end
  end

end