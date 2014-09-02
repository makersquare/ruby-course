module PuppyBreeder
  class ForSale
    attr_accessor :for_sale


    def self.add(puppy, price = nil)
      if !defined? @for_sale
        @for_sale = {}
      end

      if @for_sale[puppy.breed] == nil
        @for_sale[puppy.breed] = {}
        @for_sale[puppy.breed][:price] = price
        @for_sale[puppy.breed][:count] = 1
      elsif price == nil
        @for_sale[puppy.breed][:count] += 1
      else
        @for_sale[puppy.breed][:price] = price
        @for_sale[puppy.breed][:count] += 1
      end

      @for_sale
    end

    def self.purchase(breed)
      if @for_sale[breed] == nil || @for_sale[breed][:count] == 0
        return false
      else
        @for_sale[breed][:count] -= 1
      end
      
      @for_sale
    end

  end 
end