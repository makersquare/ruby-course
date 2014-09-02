require_relative 'spec_helper.rb'

describe PuppyBreeder::RequestContainer do
  before(:all) do
    puppy1 = PuppyBreeder::Puppy.new("Fido", "Greyhound", 30)
    puppy2 = PuppyBreeder::Puppy.new("Jack", "Great Dane", 25)
    puppy3 = PuppyBreeder::Puppy.new("Jill", "Great Dane", 50)
    PuppyBreeder::PuppyContainer.add_puppy(puppy1)
    PuppyBreeder::PuppyContainer.add_puppy(puppy2)
    PuppyBreeder::PuppyContainer.add_puppy(puppy3)

    @order1 = PuppyBreeder::PurchaseRequest.new("Boxer")
    @order2 = PuppyBreeder::PurchaseRequest.new("Great Dane")
    PuppyBreeder::RequestContainer.add_order(@order1)
    PuppyBreeder::RequestContainer.add_order(@order2)
  end

  describe '.get_completed_orders' do
    it 'returns the orders which have a status of complete' do
      expect(PuppyBreeder::RequestContainer.get_completed_orders.size).to eq(0)
    end
  end

  describe '.review_purchase_request' do
    it 'returns order which has a status of pending using id' do
      res1 = PuppyBreeder::RequestContainer.review_purchase_request
      expect(res1).to include(@order1)
    end
  end

  describe '.accept_purchase_request' do
    it 'accept the purchase request with given id' do
      PuppyBreeder::RequestContainer.accept_purchase_request
      expect(PuppyBreeder::RequestContainer.get_completed_orders).to include(@order1)
    end
  end
end