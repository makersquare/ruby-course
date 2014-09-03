module PuppyBreeder
  class Inventory
    attr_reader :puppies
    def initialize
      @puppies = Hash.new(0) #this is the hash for
    end

    def add_breed(breed, price) #talked to jimmy about my rough idea for this
      #and he helped me flesh it out
      #should have added an if @puppies[breed]
      #truthyness to test for the breed already
      #existing
      @puppies[breed] = {
        "price" => price,
        "list" => []
      }
    end

    def add_puppy(puppy) #Professor Nick helped here
      #add if else statement - check the new puppy breed against 
      #the hold list and ############################
      @puppies[puppy.breed]["list"] << puppy

    end

  end
end

#could have set the methods to class methods so
#I didn't ahve to create an instatiated object
