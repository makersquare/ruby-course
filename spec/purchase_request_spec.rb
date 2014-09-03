require_relative 'spec_helper.rb'

describe PuppyBreeder::PurchaseRequest do

  describe '.initialize' do

    it 'sets the breed and price' do
      request = PuppyBreeder::PurchaseRequest.new("golden retriever")
      expect(request.breed).to eq("golden retriever")
      expect(request.price).to eq(200)
    end

    it 'adds itself into the RequestManager open_requests' do
      request = PuppyBreeder::PurchaseRequest.new("golden retriever")
      expect(PuppyBreeder::RequestManager.view_open_requests.include?(request)).to eq(true)
    end

  end

end