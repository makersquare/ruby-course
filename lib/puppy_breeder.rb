# we initialize the module here to use in our other files
module PuppyBreeder
  @@puppies = {}

  @@breed_prices = {
    "Greyhound" => 250,
    "Boxer" => 300,
    "Great Dane" => 400
  }

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

require_relative 'puppy_breeder/puppy.rb'
require_relative 'puppy_breeder/purchase_request.rb'