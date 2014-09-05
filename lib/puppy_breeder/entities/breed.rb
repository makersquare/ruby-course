module PuppyBreeder
  class Breed
    attr_accessor :breed, :price
    
    def initialize(breed, price=300)
      @breed = breed
      @price = price
    end
  end
end