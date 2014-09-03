#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  
  class PuppyContainer

    @@puppies_hash = {}

    def self.guard_or_change(breed)
      if breed.is_a?(Symbol)
        return breed
      else
        breed = PuppyBreeder::BreedFixer.symbol(breed)
      end
    end

    def self.add_breed(breed, price=9999)
      breed = self.guard_or_change(breed)
      @@puppies_hash[breed] = {
        :price => price,
        :dog_list => []
      }
    end

    def self.check_breed(breed)
      breed = self.guard_or_change(breed)
      @@puppies_hash.has_key?(breed)
    end

    def self.check_price(breed)
      breed = self.guard_or_change(breed)
      @@puppies_hash[breed][:price]
    end

    def self.add_puppy(puppy)
      breed = self.guard_or_change(breed)
      if @@puppies_hash.has_key?(breed)
        @@puppies_hash[breed][:dog_list] << puppy
      else
        self.add_breed(breed)
        self.add_puppy(puppy)
      end
    end

    def self.get_puppy(breed)
      breed = self.guard_or_change(breed)
      @@puppies_hash[breed][:dog_list].pop
    end

    def self.market_correction(breed, price)
      breed = self.guard_or_change(breed)
      @@puppies_hash[breed][:price] = price
    end

    def self.puppy_info(breed)
      breed = self.guard_or_change(breed)
      @@puppies_hash[breed][:dog_list]
    end
    
  end
end