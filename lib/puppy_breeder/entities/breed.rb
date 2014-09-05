module PuppyBreeder
  class Breed
    attr_reader :breed, :price
    
    def initialize(breed, price=300)
      @breed = breed
      @price = price
    end
  end
end