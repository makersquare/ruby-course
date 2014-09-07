module PuppyPalace
  class Breed
    attr_reader :breed, :price
    
    def initialize(breed,price)
      @breed = breed
      @price = price
    end
  end
end