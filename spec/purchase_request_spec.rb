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
    it 'defauts the status to pending' do
      expect(@purchase_req.status).to eq("pending")
    end
  end

  describe '#completed?' do
    it 'returns false if the order has a status of pending' do
      expect(@purchase_req.completed?).to eq(false)
    end
  end
end