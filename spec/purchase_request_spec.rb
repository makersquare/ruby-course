require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do
  before(:all) do
    @purchase_req = PuppyBreeder::PurchaseRequest.new("Greyhound")
  end

  describe '#initialize' do
    it 'creates a PuppyBreeder::PurchaseRequest object' do
      expect(@purchase_req).to be_an_instance_of(PuppyBreeder::PurchaseRequest)
    end
    it 'initializes a purchase request for a given breed' do
      expect(@purchase_req.breed).to eq("Greyhound")
    end
    it 'pushes the order to a class variable array of @@orders' do
      expect(PuppyBreeder::PurchaseRequest.orders.first).to eq(@purchase_req)
    end
  end
end