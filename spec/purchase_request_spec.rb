require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do
  # before(:each) { PuppyBreeder::Requests.instance_variable_set :@purchase_orders, [] }
  # before(:each) { PuppyBreeder::PurchaseRequest.class_variable_set :@@counter, 1 }

  describe '.initialize' do
    it "creates a new purchase request for a breed with a status of pending" do
      spot = PuppyBreeder::Puppy.new("Spot", 1, "Golden Retriever")
      puppies = PuppyBreeder::Repos::Puppies.new
      puppies.add_puppy(spot)
      request = PuppyBreeder::PurchaseRequest.new("Golden Retriever")

      expect(request.breed).to eq("Golden Retriever")
      expect(request.status).to eq(:pending)
    end

    # it "shows how a purchase request was submitted with a default of by_customer" do
    #   request1 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
    #   request2 = PuppyBreeder::PurchaseRequest.new("Pitbull", :fax)
    #   result1 = request1.method
    #   result2 = request2.method

    #   expect(result1).to eq(:by_customer)
    #   expect(result2).to eq(:fax)
    # end

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

  # describe '#completed_orders' do
  #   it "returns all orders with a status of completed" do
  #     request = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
  #     request.accept

  #     result = PuppyBreeder::PurchaseRequest.completed_orders
  #     expect(result.size).to eq 1
  #     expect(result.first.status).to eq(:completed)
  #   end
  # end

  describe '.on_hold!' do
    it "changes the purchase request status from pending to on_hold" do
      request = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      request.on_hold!

      expect(request.status).to eq(:on_hold)
    end
  end

end





