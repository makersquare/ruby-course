require_relative 'spec_helper.rb'

describe PuppyBreeder::PuppyManager do

  describe '.add_puppy_for_sale' do

    it 'pushes the given puppy argument into the PuppyManager @@puppies_for_sale array' do

      puppy = PuppyBreeder::Puppy.new("Spot", "golden retriever", 1)

      PuppyBreeder::PuppyManager.add_puppy_for_sale(puppy)

      expect(PuppyBreeder::PuppyManager.puppies_for_sale.include?(puppy)).to eq(true)
    end

    it 'checks Request Managers @@held_requests automatically and approves that request if a matching puppy was found' do

      PuppyBreeder::RequestManager.clear_all_requests
      PuppyBreeder::PuppyManager.clear_puppies

      request = PuppyBreeder::PurchaseRequest.new("golden retriever")
      PuppyBreeder::RequestManager.approve_request(request)

      puppy = PuppyBreeder::Puppy.new("Spot", "golden retriever", 1)
      PuppyBreeder::PuppyManager.add_puppy_for_sale(puppy)
      PuppyBreeder::RequestManager.approve_request(request)

      expect(PuppyBreeder::PuppyManager.puppies_for_sale.include?(puppy)).to eq(false)
  end

  end

  describe '.remove_puppy_for_sale' do

    it 'deletes the given puppy argument from the PuppyManager @@pupies_for_sale array' do

      puppy = PuppyBreeder::Puppy.new("Spot", "golden retriever", 1)

      PuppyBreeder::PuppyManager.add_puppy_for_sale(puppy)
      PuppyBreeder::PuppyManager.remove_puppy_for_sale(puppy)

      expect(PuppyBreeder::PuppyManager.puppies_for_sale.include?(puppy)).to eq(false)


    end

  end


  describe '.puppies_for_sale' do

    it 'returns the puppies currently for sale (the PuppyManager @@puppies_for_sale' do

      puppy1 = PuppyBreeder::Puppy.new("Spot", "golden retriever", 1)
      puppy2 = PuppyBreeder::Puppy.new("Bowser", "golden retriever", 0.5)

      #Clear all remnant puppies for test accuracy
      PuppyBreeder::PuppyManager.clear_puppies

      PuppyBreeder::PuppyManager.add_puppy_for_sale(puppy1)
      PuppyBreeder::PuppyManager.add_puppy_for_sale(puppy2)

      expect(PuppyBreeder::PuppyManager.puppies_for_sale).to eq([puppy1, puppy2])


    end

  end

  describe '.clear_puppies' do 

    it 'empties the PuppyManager @@puppies_for_sale array' do 

      puppy1 = PuppyBreeder::Puppy.new("Spot", "golden retriever", 1)
      puppy2 = PuppyBreeder::Puppy.new("Bowser", "golden retriever", 0.5)

      PuppyBreeder::PuppyManager.add_puppy_for_sale(puppy1)
      PuppyBreeder::PuppyManager.add_puppy_for_sale(puppy2)

      PuppyBreeder::PuppyManager.clear_puppies
      expect(PuppyBreeder::PuppyManager.puppies_for_sale).to eq([])
      

    end

  end

  describe '.find_match' do

    it 'returns the first puppy of the breed specified in the purchase request' do
      puppy1 = PuppyBreeder::Puppy.new("Spot", "golden retriever", 1)
      puppy2 = PuppyBreeder::Puppy.new("Bowser", "golden retriever", 0.5)

      PuppyBreeder::PuppyManager.add_puppy_for_sale(puppy1)
      PuppyBreeder::PuppyManager.add_puppy_for_sale(puppy2)

      request = PuppyBreeder::PurchaseRequest.new("golden retriever")

      expect(PuppyBreeder::PuppyManager.find_match(request)).to eq(puppy1)
    end

  end


end