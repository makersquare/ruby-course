require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do

  request_manager = PuppyBreeder.request_repo
  puppy_manager = PuppyBreeder.puppy_repo

  describe '.initialize' do

    it 'sets the breed and price' do
      request = PuppyBreeder::PurchaseRequest.new("golden retriever")
      expect(request.breed).to eq("golden retriever")
      expect(request.price).to eq(200)
    end

    it 'adds itself into the RequestManager open_requests' do
      request = PuppyBreeder::PurchaseRequest.new("golden retriever")
      expect(request_manager.view_open_requests.include?(request)).to eq(true)
    end

  end

end