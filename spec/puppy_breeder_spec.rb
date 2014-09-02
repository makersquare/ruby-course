require_relative 'spec_helper.rb'

describe PuppyBreeder do
  before(:all) do
    puppy1 = PuppyBreeder::Puppy.new("Fido", "Greyhound", 30)
    puppy2 = PuppyBreeder::Puppy.new("Jack", "Great Dane", 25)
    puppy3 = PuppyBreeder::Puppy.new("Jill", "Great Dane", 50)
    PuppyBreeder.add_puppy(puppy1)
    PuppyBreeder.add_puppy(puppy2)
    PuppyBreeder.add_puppy(puppy3)

    @order1 = PuppyBreeder::PurchaseRequest.new("Boxer")
    @order2 = PuppyBreeder::PurchaseRequest.new("Great Dane")
    PuppyBreeder.add_order(@order1)
    PuppyBreeder.add_order(@order2)
  end

  describe '.add_puppy' do
    it 'creates a data structure (hash) which stores puppies by breed' do
      expect(PuppyBreeder.get_puppies).to be_a(Hash)
    end
  end

  describe '.get_completed_orders' do
    it 'returns the orders which have a status of complete' do
      expect(PuppyBreeder.get_completed_orders.size).to eq(0)
    end
  end

  describe '.review_purchase_request' do
    it 'returns order which has a status of pending using id' do
      res1 = PuppyBreeder.review_purchase_request(@order1.id)
      res2 = PuppyBreeder.review_purchase_request(@order2.id)
      expect(res1).to include(@order1)
      expect(res2).to include(@order2)
    end
  end

  describe '.accept_purchase_request' do
    it 'accept the purchase request with given id' do
      PuppyBreeder.accept_purchase_request(@order1.id)
      expect(PuppyBreeder.get_completed_orders.first.status).to eq('complete')
    end
  end
end