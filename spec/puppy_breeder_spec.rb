require_relative 'spec_helper.rb'

describe PuppyBreeder do
  before(:all) do
    puppy1 = PuppyBreeder::Puppy.new("Fido", "Greyhound", 30)
    puppy2 = PuppyBreeder::Puppy.new("Jack", "Great Dane", 25)
    puppy3 = PuppyBreeder::Puppy.new("Jill", "Great Dane", 50)
    PuppyBreeder.add_puppy(puppy1)
    PuppyBreeder.add_puppy(puppy2)
    PuppyBreeder.add_puppy(puppy3)

  end
  describe '.add_puppy' do
    it 'creates a data structure (hash) which stores puppies by breed' do
      expect(PuppyBreeder.get_puppies).to be_a(Hash)
    end
  end

  describe '.get_completed_orders' do
    it 'returns the orders which have a status of complete' do
      PuppyBreeder::PurchaseRequest.new("Boxer")
      PuppyBreeder::PurchaseRequest.new("Great Dane")
      expect(PuppyBreeder.get_completed_orders.size).to eq(0)
    end
  end

  describe '.review_purchase_requests' do
    it 'returns all of the orders which have a status of pending' do
      expect(PuppyBreeder.review_purchase_requests.size).to eq(2)
    end
  end

  describe '.accept_purchase_requests' do
    it 'accepts all of the purchase requests' do
      PuppyBreeder.accept_purchase_requests
      binding.pry
      expect(PuppyBreeder.get_completed_orders.size).to eq(2)
    end
  end
end