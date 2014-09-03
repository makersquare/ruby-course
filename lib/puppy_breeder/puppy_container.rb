#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  
  class PuppyContainer

    @@puppies_hash = {}

    def self.add_breed(breed, price=9999)
      @@puppies_hash[breed] = {
        :price => price,
        :dog_list => []
      }
    end

    def self.check_breed(breed)
      @@puppies_hash.has_key?(breed)
    end

    def self.add_puppy(puppy)
      if @@puppies_hash.has_key?(puppy.breed)
        @@puppies_hash[puppy.breed][:dog_list] << puppy
      else
        self.add_breed(puppy.breed)
        self.add_puppy(puppy)
      end
    end

    def self.get_puppy(breed)
      @@puppies_hash[breed][:dog_list].pop
    end

    def self.market_correction(breed, price)
      @@puppies_hash[breed][:price] = price
    end

    def self.puppy_info(breed)
      @@puppies_hash[breed][:dog_list]
    end
    
  end
end