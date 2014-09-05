require_relative 'spec_helper.rb'

describe PuppyBreeder::PuppyManager do

  request_manager = PuppyBreeder.request_repo
  puppy_manager = PuppyBreeder.puppy_repo

  describe '.add_puppy_for_sale' do

    it 'pushes the given puppy argument into the PuppyManager @@puppies_for_sale array' do

      puppy = PuppyBreeder::Puppy.new("Spot", "golden retriever", 1)

      puppy_manager.add_puppy_for_sale(puppy)

      expect(puppy_manager.puppies_for_sale.include?(puppy)).to eq(true)
    end

    it 'checks Request Managers @@held_requests automatically and approves that request if a matching puppy was found' do

      request_manager.clear_all_requests
      puppy_manager.clear_puppies

      request = PuppyBreeder::PurchaseRequest.new("golden retriever")
      request_manager.approve_request(request)

      puppy = PuppyBreeder::Puppy.new("Spot", "golden retriever", 1)
      puppy_manager.add_puppy_for_sale(puppy)
      request_manager.approve_request(request)

      expect(puppy_manager.puppies_for_sale.include?(puppy)).to eq(false)
  end

  end

  describe '.remove_puppy_for_sale' do

    it 'deletes the given puppy argument from the PuppyManager @@pupies_for_sale array' do

      puppy = PuppyBreeder::Puppy.new("Spot", "golden retriever", 1)

      puppy_manager.add_puppy_for_sale(puppy)
      puppy_manager.remove_puppy_for_sale(puppy)

      expect(puppy_manager.puppies_for_sale.include?(puppy)).to eq(false)


    end

  end


  describe '.puppies_for_sale' do

    it 'returns the puppies currently for sale (the PuppyManager @@puppies_for_sale' do

      puppy1 = PuppyBreeder::Puppy.new("Spot", "golden retriever", 1)
      puppy2 = PuppyBreeder::Puppy.new("Bowser", "golden retriever", 0.5)

      #Clear all remnant puppies for test accuracy
      puppy_manager.clear_puppies

      puppy_manager.add_puppy_for_sale(puppy1)
      puppy_manager.add_puppy_for_sale(puppy2)

      expect(puppy_manager.puppies_for_sale).to eq([puppy1, puppy2])


    end

  end

  describe '.clear_puppies' do 

    it 'empties the PuppyManager @@puppies_for_sale array' do 

      puppy1 = PuppyBreeder::Puppy.new("Spot", "golden retriever", 1)
      puppy2 = PuppyBreeder::Puppy.new("Bowser", "golden retriever", 0.5)

      puppy_manager.add_puppy_for_sale(puppy1)
      puppy_manager.add_puppy_for_sale(puppy2)

      puppy_manager.clear_puppies
      expect(puppy_manager.puppies_for_sale).to eq([])
      

    end

  end

  describe '.find_match' do

    it 'returns the first puppy of the breed specified in the purchase request' do
      puppy1 = PuppyBreeder::Puppy.new("Spot", "golden retriever", 1)
      puppy2 = PuppyBreeder::Puppy.new("Bowser", "golden retriever", 0.5)

      puppy_manager.add_puppy_for_sale(puppy1)
      puppy_manager.add_puppy_for_sale(puppy2)

      request = PuppyBreeder::PurchaseRequest.new("golden retriever")

      expect(puppy_manager.find_match(request)).to eq(puppy1)
    end

  end


end