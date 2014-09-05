require_relative 'spec_helper.rb'  

describe PuppyBreeder::RequestManager do

  request_manager = PuppyBreeder.request_repo
  puppy_manager = PuppyBreeder.puppy_repo

  describe '.add_request' do

    it 'adds the given purchase_request argument to the RequestManagers @@open_requests array' do

      request_manager.clear_all_requests
      puppy_manager.clear_puppies

      request = PuppyBreeder::PurchaseRequest.new("afghan hound")

      expect(request_manager.view_open_requests).to eq([request])

    end

  end

  describe '.approve_request' do

    it 'moves the given request from  RequestManagers @@open_requests to @@completed_requests IF the matching pup is the same breed as the request' do

      request_manager.clear_all_requests
      puppy_manager.clear_puppies

      puppy = PuppyBreeder::Puppy.new("Billy", "afghan hound", 1)
      puppy_manager.add_puppy_for_sale(puppy)

      request = PuppyBreeder::PurchaseRequest.new("afghan hound")
      request_manager.approve_request(request)

      expect(request_manager.view_open_requests.include?(request)).to eq(false)
      expect(request_manager.view_completed_requests.include?(request)).to eq(true)

    end

    it 'moves the given requests from RequestManagers @@open_requests to @@held_requests IF the matching pup is not available' do

      request_manager.clear_all_requests
      puppy_manager.clear_puppies

      puppy = PuppyBreeder::Puppy.new("Billy", "golden retriever", 1)
      puppy_manager.add_puppy_for_sale(puppy)

      request = PuppyBreeder::PurchaseRequest.new("afghan hound")
      request_manager.approve_request(request)

      expect(request_manager.view_open_requests.include?(request)).to eq(false)
      expect(request_manager.view_held_requests.include?(request)).to eq(true)

    end

    it 'finds a matching puppy' do

      request_manager.clear_all_requests
      puppy_manager.clear_puppies

      puppy = PuppyBreeder::Puppy.new("Billy", "afghan hound", 1)
      puppy_manager.add_puppy_for_sale(puppy)

      request = PuppyBreeder::PurchaseRequest.new("afghan hound")
      match = puppy_manager.find_match(request)

      expect(puppy.breed == request.breed).to eq(true) 


    end

    it 'removes the matching puppy from the PuppyManagers @@puppies_for_sale' do

      request_manager.clear_all_requests
      puppy_manager.clear_puppies

      puppy = PuppyBreeder::Puppy.new("Billy", "afghan hound", 1)
      puppy_manager.add_puppy_for_sale(puppy)

      request = PuppyBreeder::PurchaseRequest.new("afghan hound")
      match = puppy_manager.find_match(request)

      request_manager.approve_request(request)

      expect(puppy_manager.puppies_for_sale.include?(match)).to eq(false)

    end

  end

  describe '.deny_request' do

    it 'removes the request from RequestManagers @@open_requests and adds it to the @@denied_requests' do

      request_manager.clear_all_requests
      puppy_manager.clear_puppies

      request = PuppyBreeder::PurchaseRequest.new("afghan hound")
      request_manager.deny_request(request)

      expect(request_manager.view_open_requests.include?(request)).to eq(false)
      expect(request_manager.view_denied_requests.include?(request)).to eq(true)

    end

  end

  describe '.view_open_requests' do

    it 'returns the @@open_requests array' do 

      request_manager.clear_all_requests
      puppy_manager.clear_puppies

      request = PuppyBreeder::PurchaseRequest.new("afghan hound")

      expect(request_manager.view_open_requests).to eq([request])


    end

  end

  describe '.view_completed_requests' do

    it 'returns the @@completed_requests array' do 

      request_manager.clear_all_requests
      puppy_manager.clear_puppies

      puppy = PuppyBreeder::Puppy.new("Billy", "afghan hound", 1)
      puppy_manager.add_puppy_for_sale(puppy)

      request = PuppyBreeder::PurchaseRequest.new("afghan hound")
      request_manager.approve_request(request)

      expect(request_manager.view_completed_requests).to eq([request])

    end

  end

  describe '.view_denied_requests' do

    it 'returns the @@denied_requests array' do 

      request_manager.clear_all_requests
      puppy_manager.clear_puppies

      request = PuppyBreeder::PurchaseRequest.new("afghan hound")
      request_manager.deny_request(request)

      expect(request_manager.view_denied_requests).to eq([request])

    end

  end

  describe '.clear_all_requests' do

    it 'sets @@completed_requests, @@open_requests, and @@denied_requests to empty' do 

      request_manager.clear_all_requests
      puppy_manager.clear_puppies

      puppy1 = PuppyBreeder::Puppy.new("Billy", "afghan hound", 1)
      puppy_manager.add_puppy_for_sale(puppy1)

      puppy2 = PuppyBreeder::Puppy.new("Billy", "afghan hound", 1)
      puppy_manager.add_puppy_for_sale(puppy2)

      request1 = PuppyBreeder::PurchaseRequest.new("afghan hound")
      request2 = PuppyBreeder::PurchaseRequest.new("afghan hound")
      request3 = PuppyBreeder::PurchaseRequest.new("afghan hound")
      request_manager.approve_request(request1)
      request_manager.deny_request(request2)

      expect(request_manager.view_completed_requests).to eq([request1])
      expect(request_manager.view_denied_requests).to eq([request2])
      expect(request_manager.view_open_requests).to eq([request3])

    end

  end



end