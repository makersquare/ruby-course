module PuppyBreeder
  class PuppyContainer
    @@puppies = {}
    @@breed_prices = {
      "Greyhound" => 250,
      "Boxer" => 300,
      "Great Dane" => 400
    }

    def self.add_breed(breed, price=999)
      @@breed_prices[breed] = price
    end
    
    def self.add_puppy(puppy)
      if @@puppies.has_key?(puppy.breed)
        @@puppies[puppy.breed][:list].push(puppy)
      else
        @@puppies[puppy.breed] = {
          :price => @@breed_prices[puppy.breed],
          :list => [puppy]
        }
      end
    end

    def self.get_puppies
      @@puppies
    end
  end
end