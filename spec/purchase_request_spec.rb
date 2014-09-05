require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do
  before(:all) do
    @purchase_req = PuppyBreeder::PurchaseRequest.new("Poodle")
  end

  describe '#initialize' do
    it 'creates a PuppyBreeder::PurchaseRequest object' do
      expect(@purchase_req).to be_an_instance_of(PuppyBreeder::PurchaseRequest)
    end
    it 'initializes a purchase request for a given breed' do
      expect(@purchase_req.breed).to eq("Poodle")
    end
    it 'defauts the status to pending' do
      expect(@purchase_req.status).to eq("pending")
    end
  end

  describe '#complete!' do
    it 'changes the status of an order to complete' do
      @purchase_req.complete!
      expect(@purchase_req.status).to eq('complete')
    end
  end

  describe '#completed?' do
    it 'returns true if the order has a status of pending' do
      expect(@purchase_req.completed?).to eq(true)
    end
  end

  describe '#hold?' do
    it 'returns true if the order has a status of hold' do
      @purchase_req.hold!
      expect(@purchase_req.hold?).to eq(true)
    end
  end

  describe '#hold!' do
    it 'changes status of order to hold' do
      @purchase_req.complete!
      expect(@purchase_req.status).to eq('complete')
      @purchase_req.hold!
      expect(@purchase_req.status).to eq('hold')
    end
  end
end