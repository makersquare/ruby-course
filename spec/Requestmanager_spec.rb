require_relative 'spec_helper.rb'

describe PuppyBreeder::RequestManager do

  describe '.add_request' do

    it 'adds the given purchase_request argument to the RequestManagers @@open_requests array' do

      request = PuppyBreeder::PurchaseRequest.new("afghan hound")

      #Clear all requests for testing purposes
      PuppyBreeder::RequestManager.clear_all_requests
      PuppyBreeder::RequestManager.add_request(request)

      expect(PuppyBreeder::RequestManager.view_open_requests).to eq([request])

    end

  end

  describe ''



end