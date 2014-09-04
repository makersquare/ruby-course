module PuppyBreeder
  class ForSale
    @for_sale = {}
    
    def self.add(puppy, price = nil)

      if !@for_sale[puppy.breed]
        @for_sale[puppy.breed] = {
          price: price,
          count: 1
        }
      else
        @for_sale[puppy.breed][:price] = price if !price
        @for_sale[puppy.breed][:count] += 1
      end

      @for_sale
    end

    def self.purchase(breed)
      if !@for_sale[breed] || @for_sale[breed][:count] == 0
        return false
      else
        @for_sale[breed][:count] -= 1
      end

      @for_sale
    end

    def self.for_sale
      @for_sale
    end

  end 
end