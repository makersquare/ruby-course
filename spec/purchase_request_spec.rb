require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do
  before(:each) { PuppyBreeder::Requests.instance_variable_set :@purchase_orders, [] }
  before(:each) { PuppyBreeder::PurchaseRequest.class_variable_set :@@counter, 1 }

  describe '.initialize' do
    it "creates a new purchase request for a breed with a status of pending" do
      request = PuppyBreeder::PurchaseRequest.new("Golden Retriever")

      expect(request.breed).to eq("Golden Retriever")
      expect(request.status).to eq(:pending)
    end

    it "shows how a purchase request was submitted with a default of by customer" do
      request = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      result = request.method

      expect(result).to eq(:by_customer)
    end

    it "creates a unique id number for each purchase request" do
      request1 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      request2 = PuppyBreeder::PurchaseRequest.new("Pitbull")

      request1.id.should_not eq(request2.id)
    end
  end

  describe '.review' do
    it "shows all pending purchase requests" do
      request1 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      request2 = PuppyBreeder::PurchaseRequest.new("Pitbull")

      result = PuppyBreeder::PurchaseRequest.review

      expect(result.size).to eq 2
      expect(result.first.class).to eq(PuppyBreeder::PurchaseRequest)
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