module PAWS
  
  class Breed
  
    attr_reader :breed, :price
  
    def initialize(breed, price=nil)
      @breed = breed
      @price = price
    end

    def update_price(price)
      @price = price
    end
  
  end

end