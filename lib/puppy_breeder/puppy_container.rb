#Refer to this class as PuppyBreeder::PuppyContainer
module PuppyBreeder
  class PuppyContainer

# Access puppies hash.
    attr_accessor :puppies

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

# Removes puppy from :available_puppies array if that puppy is available.
    def remove_puppy(puppy)
      if @puppies[puppy.breed][:available_puppies].include?(puppy)
        @puppies[puppy.breed][:available_puppies].delete(puppy)
      end
    end

# Finds out whether that breed of puppy is available.
    def breed_availability(breed)
      if @puppies[breed][:available_puppies].length > 0
        @puppies[breed][:available_puppies]
      end
    end

  end
end