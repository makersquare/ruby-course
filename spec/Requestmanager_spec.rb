require_relative 'spec_helper.rb'  

describe PuppyBreeder::Repos::RequestManager do

  request_manager = PuppyBreeder.request_repo
  puppy_manager = PuppyBreeder.puppy_repo

  describe '.add_request' do

    it 'adds the given purchase_request argument to the RequestManagers @@open_requests array' do

      request_manager.clear_all_requests
      puppy_manager.clear_puppies

      request = PuppyBreeder::PurchaseRequest.new("afghan hound", request_manager)
      breed = request.breed
      price = request.price

      expect(request_manager.view_open_requests[0].breed).to eq(breed)
      expect(request_manager.view_open_requests[0].price).to eq(price)

    end

  end

  describe '.approve_request' do

    it 'moves the given request from  RequestManagers @@open_requests to @@completed_requests IF the matching pup is the same breed as the request' do

      request_manager.clear_all_requests
      puppy_manager.clear_puppies

      puppy = PuppyBreeder::Puppy.new("Billy", "afghan hound", 1)
      puppy_manager.add_puppy_for_sale(puppy, PuppyBreeder.request_repo)

      request = PuppyBreeder::PurchaseRequest.new("afghan hound", request_manager)
      request_manager.approve_request(request, PuppyBreeder.puppy_repo)

      breed = request.breed
      price = request.price

      expect(request_manager.view_open_requests[0]).to eq(nil)
      expect(request_manager.view_completed_requests[0].breed).to eq(breed)
      expect(request_manager.view_completed_requests[0].price).to eq(price)

    end

    it 'moves the given requests from RequestManagers @@open_requests to @@held_requests IF the matching pup is not available' do

      request_manager.clear_all_requests
      puppy_manager.clear_puppies

      puppy = PuppyBreeder::Puppy.new("Billy", "golden retriever", 1)
      puppy_manager.add_puppy_for_sale(puppy, PuppyBreeder.request_repo)

      request = PuppyBreeder::PurchaseRequest.new("afghan hound", request_manager)
      request_manager.approve_request(request, PuppyBreeder.puppy_repo)

      breed = request.breed
      price = request.price

      expect(request_manager.view_open_requests[0]).to eq(nil)
      expect(request_manager.view_held_requests[0].breed).to eq(breed)
      expect(request_manager.view_held_requests[0].price).to eq(price)

    end

    it 'finds a matching puppy' do

      request_manager.clear_all_requests
      puppy_manager.clear_puppies

      puppy = PuppyBreeder::Puppy.new("Billy", "afghan hound", 1)
      puppy_manager.add_puppy_for_sale(puppy, PuppyBreeder.request_repo)

      request = PuppyBreeder::PurchaseRequest.new("afghan hound", request_manager)
      match = puppy_manager.find_match(request)

      expect(puppy.breed == request.breed).to eq(true) 


    end

    it 'removes the matching puppy from the PuppyManagers @@puppies_for_sale' do

      request_manager.clear_all_requests
      puppy_manager.clear_puppies

      puppy = PuppyBreeder::Puppy.new("Billy", "afghan hound", 1)
      puppy_manager.add_puppy_for_sale(puppy, PuppyBreeder.request_repo)

      request = PuppyBreeder::PurchaseRequest.new("afghan hound", request_manager)
      match = puppy_manager.find_match(request)

      request_manager.approve_request(request, PuppyBreeder.puppy_repo)

      expect(puppy_manager.puppies_for_sale.include?(match)).to eq(false)

    end

  end

  describe '.deny_request' do

    it 'removes the request from RequestManagers @@open_requests and adds it to the @@denied_requests' do

      request_manager.clear_all_requests
      puppy_manager.clear_puppies

      request = PuppyBreeder::PurchaseRequest.new("afghan hound", request_manager)
      request_manager.deny_request(request)

      breed = request.breed
      price = request.price

      expect(request_manager.view_open_requests[0]).to eq(nil)
      expect(request_manager.view_denied_requests[0].breed).to eq(breed)
      expect(request_manager.view_denied_requests[0].price).to eq(price)

    end

  end

  describe '.view_open_requests' do

    it 'returns the @@open_requests array' do 

      request_manager.clear_all_requests
      puppy_manager.clear_puppies

      request = PuppyBreeder::PurchaseRequest.new("afghan hound", request_manager)

      breed = request.breed
      price = request.price

      expect(request_manager.view_open_requests[0].breed).to eq(breed)
      expect(request_manager.view_open_requests[0].price).to eq(price)

    end

  end

  describe '.view_completed_requests' do

    it 'returns the @@completed_requests array' do 

      request_manager.clear_all_requests
      puppy_manager.clear_puppies

      puppy = PuppyBreeder::Puppy.new("Billy", "afghan hound", 1)
      puppy_manager.add_puppy_for_sale(puppy, PuppyBreeder.request_repo)

      request = PuppyBreeder::PurchaseRequest.new("afghan hound", request_manager)
      request_manager.approve_request(request, PuppyBreeder.puppy_repo)

      breed = request.breed
      price = request.price

      expect(request_manager.view_completed_requests[0].breed).to eq(breed)
      expect(request_manager.view_completed_requests[0].price).to eq(price)

    end

  end

  describe '.view_denied_requests' do

    it 'returns the @@denied_requests array' do 

      request_manager.clear_all_requests
      puppy_manager.clear_puppies

      request = PuppyBreeder::PurchaseRequest.new("afghan hound", request_manager)
      request_manager.deny_request(request)

      breed = request.breed
      price = request.price

      expect(request_manager.view_denied_requests[0].breed).to eq(breed)
      expect(request_manager.view_denied_requests[0].price).to eq(price)


    end

  end

  describe '.clear_all_requests' do

    it 'sets @@completed_requests, @@open_requests, and @@denied_requests to empty' do 

      request_manager.clear_all_requests
      puppy_manager.clear_puppies

      puppy1 = PuppyBreeder::Puppy.new("Billy", "afghan hound", 1)
      puppy_manager.add_puppy_for_sale(puppy1, PuppyBreeder.request_repo)

      puppy2 = PuppyBreeder::Puppy.new("Billy", "afghan hound", 1)
      puppy_manager.add_puppy_for_sale(puppy2, PuppyBreeder.request_repo)

      request1 = PuppyBreeder::PurchaseRequest.new("afghan hound", request_manager)
      request2 = PuppyBreeder::PurchaseRequest.new("afghan hound", request_manager)
      request3 = PuppyBreeder::PurchaseRequest.new("afghan hound", request_manager)
      request_manager.approve_request(request1, PuppyBreeder.puppy_repo)
      request_manager.deny_request(request2)

      breed1 = request1.breed
      price1 = request1.price
      breed2 = request2.breed
      price2 = request2.price
      breed3 = request3.breed
      price3 = request3.price


      expect(request_manager.view_completed_requests[0].breed).to eq(breed1)
      expect(request_manager.view_completed_requests[0].price).to eq(price1)
      expect(request_manager.view_denied_requests[0].breed).to eq(breed2)
      expect(request_manager.view_denied_requests[0].price).to eq(price2)
      expect(request_manager.view_open_requests[0].breed).to eq(breed3)
      expect(request_manager.view_open_requests[0].price).to eq(price3)

    end

  end



end