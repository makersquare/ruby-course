module PAWS
  
  class Breed
  
    attr_reader :breed, :price, :id
  
    def initialize(breed, price=nil, id=nil)
      @breed = breed
      @price = price
      @id = id
    end

    def update_price(price)
      @price = price
    end
  
  end

end