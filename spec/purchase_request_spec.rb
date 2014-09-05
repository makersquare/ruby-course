require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do

  request_manager = PuppyBreeder.request_repo
  puppy_manager = PuppyBreeder.puppy_repo

  describe '.initialize' do

    it 'sets the breed and price' do
      request = PuppyBreeder::PurchaseRequest.new("golden retriever", PuppyBreeder.request_repo)
      expect(request.breed).to eq("golden retriever")
      expect(request.price).to eq(200)
    end

    it 'adds itself into the RequestManager open_requests' do
      request = PuppyBreeder::PurchaseRequest.new("golden retriever", PuppyBreeder.request_repo)

      breed = request.breed
      price = request.price

      expect(request_manager.view_open_requests[0].breed).to eq(breed)
      expect(request_manager.view_open_requests[0].price).to eq(price)
    end

  end

end