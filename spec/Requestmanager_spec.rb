require_relative 'spec_helper.rb'

describe PuppyBreeder::RequestManager do

  describe '.add_request' do

    it 'adds the given purchase_request argument to the RequestManagers @@open_requests array' do

      PuppyBreeder::RequestManager.clear_all_requests
      PuppyBreeder::PuppyManager.clear_puppies

      request = PuppyBreeder::PurchaseRequest.new("afghan hound")

      expect(PuppyBreeder::RequestManager.view_open_requests).to eq([request])

    end

  end

  describe '.approve_request' do

    it 'moves the given request from  RequestManagers @@open_requests to @@completed_requests' do

      PuppyBreeder::RequestManager.clear_all_requests
      PuppyBreeder::PuppyManager.clear_puppies

      request = PuppyBreeder::PurchaseRequest.new("afghan hound")
      PuppyBreeder::RequestManager.approve_request(request)

      expect(PuppyBreeder::RequestManager.view_open_requests.include?(request)).to eq(false)
      expect(PuppyBreeder::RequestManager.view_completed_requests.include?(request)).to eq(true)

    end

    it 'finds a matching puppy' do

      PuppyBreeder::RequestManager.clear_all_requests
      PuppyBreeder::PuppyManager.clear_puppies

      puppy = PuppyBreeder::Puppy.new("Billy", "afghan hound", 1)
      PuppyBreeder::PuppyManager.add_puppy_for_sale(puppy)

      request = PuppyBreeder::PurchaseRequest.new("afghan hound")
      match = PuppyBreeder::PuppyManager.find_match(request)

      expect(puppy.breed == request.breed).to eq(true) 


    end

    it 'removes the matching puppy from the PuppyManagers @@puppies_for_sale' do

      PuppyBreeder::RequestManager.clear_all_requests
      PuppyBreeder::PuppyManager.clear_puppies

      puppy = PuppyBreeder::Puppy.new("Billy", "afghan hound", 1)
      PuppyBreeder::PuppyManager.add_puppy_for_sale(puppy)

      request = PuppyBreeder::PurchaseRequest.new("afghan hound")
      match = PuppyBreeder::PuppyManager.find_match(request)

      PuppyBreeder::RequestManager.approve_request(request)

      expect(PuppyBreeder::PuppyManager.puppies_for_sale.include?(match)).to eq(false)

    end

  end

  describe '.deny_request' do

    it 'removes the request from RequestManagers @@open_requests and adds it to the @@denied_requests' do

      PuppyBreeder::RequestManager.clear_all_requests
      PuppyBreeder::PuppyManager.clear_puppies

      request = PuppyBreeder::PurchaseRequest.new("afghan hound")
      PuppyBreeder::RequestManager.deny_request(request)

      expect(PuppyBreeder::RequestManager.view_open_requests.include?(request)).to eq(false)
      expect(PuppyBreeder::RequestManager.view_denied_requests.include?(request)).to eq(true)

    end

  end

  describe '.view_open_requests' do

    it 'returns the @@open_requests array' do 

      PuppyBreeder::RequestManager.clear_all_requests
      PuppyBreeder::PuppyManager.clear_puppies

      request = PuppyBreeder::PurchaseRequest.new("afghan hound")

      expect(PuppyBreeder::RequestManager.view_open_requests).to eq([request])


    end

  end

  describe '.view_completed_requests' do

    it 'returns the @@completed_requests array' do 

      PuppyBreeder::RequestManager.clear_all_requests
      PuppyBreeder::PuppyManager.clear_puppies

      request = PuppyBreeder::PurchaseRequest.new("afghan hound")
      PuppyBreeder::RequestManager.approve_request(request)

      expect(PuppyBreeder::RequestManager.view_completed_requests).to eq([request])

    end

  end

  describe '.view_denied_requests' do

    it 'returns the @@denied_requests array' do 

      PuppyBreeder::RequestManager.clear_all_requests
      PuppyBreeder::PuppyManager.clear_puppies

      request = PuppyBreeder::PurchaseRequest.new("afghan hound")
      PuppyBreeder::RequestManager.deny_request(request)

      expect(PuppyBreeder::RequestManager.view_denied_requests).to eq([request])

    end

  end

  describe '.clear_all_requests' do

    it 'sets @@completed_requests, @@open_requests, and @@denied_requests to empty' do 

      PuppyBreeder::RequestManager.clear_all_requests
      PuppyBreeder::PuppyManager.clear_puppies

      request1 = PuppyBreeder::PurchaseRequest.new("afghan hound")
      request2 = PuppyBreeder::PurchaseRequest.new("afghan hound")
      request3 = PuppyBreeder::PurchaseRequest.new("afghan hound")
      PuppyBreeder::RequestManager.approve_request(request1)
      PuppyBreeder::RequestManager.deny_request(request2)

      expect(PuppyBreeder::RequestManager.view_completed_requests).to eq([request1])
      expect(PuppyBreeder::RequestManager.view_denied_requests).to eq([request2])
      expect(PuppyBreeder::RequestManager.view_open_requests).to eq([request3])

    end

  end



end