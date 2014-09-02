require_relative 'spec_helper.rb'

describe PuppyBreeder::Requests do
  before(:each) { PuppyBreeder::Requests.instance_variable_set :@purchase_orders, [] }

  describe '#new_request' do
    it "adds a new purchase request to the purchase orders array" do
      request1 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      request2 = PuppyBreeder::PurchaseRequest.new("Pitbull")

      result = PuppyBreeder::Requests.purchase_orders

      expect(result.size).to eq 2
      expect(result.first.breed).to eq("Golden Retriever")
    end
  end

  describe '#complete_request' do
    it "removes a completed purchase order from the array"
  end

  describe '#pending_purchase_orders' do
    it "shows only purchase orders with a status of pending" do
      request1 = PuppyBreeder::PurchaseRequest.new("Golden Retriever")
      request2 = PuppyBreeder::PurchaseRequest.new("Pitbull")

      request1.accept

      result = PuppyBreeder::Requests.pending_purchase_orders

      expect(result.size).to eq 1
    end
  end

end