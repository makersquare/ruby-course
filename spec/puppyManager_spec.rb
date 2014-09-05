require_relative 'spec_helper.rb'

describe PuppyBreeder::Repos::PuppyManager do

  request_manager = PuppyBreeder.request_repo
  puppy_manager = PuppyBreeder.puppy_repo

  describe '.add_puppy_for_sale' do

    it 'pushes the given puppy argument into the PuppyManager @@puppies_for_sale array' do

      request_manager.clear_all_requests
      puppy_manager.clear_puppies

      puppy = PuppyBreeder::Puppy.new("Spot", "golden retriever", 1)

      puppy_manager.add_puppy_for_sale(puppy, PuppyBreeder.request_repo)

      name = puppy.name
      age = puppy.age
      breed = puppy.breed

      expect(puppy_manager.puppies_for_sale[0].name).to eq(name)
      expect(puppy_manager.puppies_for_sale[0].age).to eq(age)
      expect(puppy_manager.puppies_for_sale[0].breed).to eq(breed)
    end

    it 'checks Request Managers @@held_requests automatically and approves that request if a matching puppy was found' do

      request_manager.clear_all_requests
      puppy_manager.clear_puppies

      request = PuppyBreeder::PurchaseRequest.new("golden retriever", PuppyBreeder.request_repo)
      request_manager.approve_request(request, PuppyBreeder.puppy_repo)

      puppy = PuppyBreeder::Puppy.new("Spot", "golden retriever", 1)
      puppy_manager.add_puppy_for_sale(puppy, PuppyBreeder.request_repo)
      request_manager.approve_request(request, PuppyBreeder.puppy_repo)

      expect(puppy_manager.puppies_for_sale[0]).to eq(nil)

  end

  end

  describe '.remove_puppy_for_sale' do

    it 'deletes the given puppy argument from the PuppyManager @@pupies_for_sale array' do

      puppy = PuppyBreeder::Puppy.new("Spot", "golden retriever", 1)

      puppy_manager.add_puppy_for_sale(puppy, PuppyBreeder.request_repo)
      puppy_manager.remove_puppy_for_sale(puppy)

      expect(puppy_manager.puppies_for_sale.include?(puppy)).to eq(false)


    end

  end


  describe '.puppies_for_sale' do

    it 'returns the puppies currently for sale (the PuppyManager @@puppies_for_sale' do

      puppy1 = PuppyBreeder::Puppy.new("Spot", "golden retriever", 1)
      puppy2 = PuppyBreeder::Puppy.new("Bowser", "golden retriever", 1)

      #Clear all remnant puppies for test accuracy
      puppy_manager.clear_puppies

      puppy_manager.add_puppy_for_sale(puppy1, PuppyBreeder.request_repo)
      puppy_manager.add_puppy_for_sale(puppy2, PuppyBreeder.request_repo)

      age1 = puppy1.age
      age2 = puppy2.age

      name1 = puppy1.name
      name2 = puppy2.name

      breed1 = puppy1.breed
      breed2 = puppy2.breed


      expect(puppy_manager.puppies_for_sale[0].age).to eq(age1)
      expect(puppy_manager.puppies_for_sale[0].name).to eq(name1)
      expect(puppy_manager.puppies_for_sale[0].breed).to eq(breed1)

      expect(puppy_manager.puppies_for_sale[1].age).to eq(age2)
      expect(puppy_manager.puppies_for_sale[1].name).to eq(name2)
      expect(puppy_manager.puppies_for_sale[1].breed).to eq(breed2)


    end

  end

  describe '.clear_puppies' do 

    it 'empties the PuppyManager @@puppies_for_sale array' do 

      puppy1 = PuppyBreeder::Puppy.new("Spot", "golden retriever", 1)
      puppy2 = PuppyBreeder::Puppy.new("Bowser", "golden retriever", 1)

      puppy_manager.add_puppy_for_sale(puppy1, PuppyBreeder.request_repo)
      puppy_manager.add_puppy_for_sale(puppy2, PuppyBreeder.request_repo)

      puppy_manager.clear_puppies
      expect(puppy_manager.puppies_for_sale).to eq([])
      

    end

  end

  describe '.find_match' do

    it 'returns the first puppy of the breed specified in the purchase request' do
      puppy1 = PuppyBreeder::Puppy.new("Spot", "golden retriever", 1)
      puppy2 = PuppyBreeder::Puppy.new("Bowser", "golden retriever", 1)

      puppy_manager.add_puppy_for_sale(puppy1, PuppyBreeder.request_repo)
      puppy_manager.add_puppy_for_sale(puppy2, PuppyBreeder.request_repo)

      request = PuppyBreeder::PurchaseRequest.new("golden retriever", PuppyBreeder.request_repo)

      match = puppy_manager.find_match(request)
      
      name = match.name
      age = match.age

      expect(puppy1.name).to eq(name)
      expect(puppy1.age).to eq(age)
    end

  end


end