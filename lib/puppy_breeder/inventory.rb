module PuppyBreeder
  class Inventory
    attr_reader :puppies
    def initialize
      @puppies = Hash.new
    end

    def add_breed(breed, price) #talked to jimmy about this
      @puppies[breed] = {
        "price" => price,
        "quantity" => 0
      }
    end
    def puppies
      @puppies
    end
  end
end