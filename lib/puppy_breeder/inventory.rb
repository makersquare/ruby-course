module PuppyBreeder
  class Inventory
    attr_reader :puppies
    def initialize
      @puppies = Hash.new(0) #this is the hash for
    end

    def add_breed(breed, price) #talked to jimmy about my rough idea for this
      #and he helped me flesh it out
      @puppies[breed] = {
        "price" => price,
        "list" => []
      }
    end

    def add_puppy(puppy) #Professor Nick helped here
      @puppies[puppy.breed]["list"] << puppy
    end

  end
end