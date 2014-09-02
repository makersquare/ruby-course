#Refer to this class as PuppyBreeder::PuppyContainer
module PuppyBreeder
  class PuppyContainer

# Access
    attr_accessor :puppies
    attr_reader :name

# Initialization creates a name variable and an empty hash with default value of 0.
    def initialize
      @puppies = Hash.new(0)
    end

# Adds breed and cost of breed to container.
    def add_breed(breed, cost)
      @puppies[breed] = { 
        :price => cost,
        :available_puppies => []
      }
    end

# Adds a puppy to container. Puppy's breed must be added to container before puppy of that breed can be added, that way a price and available puppies array can be already established.
    def add_puppy(puppy)
      @puppies[puppy.breed][:available_puppies] << puppy
    end

  end
end