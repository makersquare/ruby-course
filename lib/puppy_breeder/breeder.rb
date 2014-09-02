module PuppyBreeder
  class Breeder
    attr_accessor :puppy_inventory, :purchase_requests
    
    def initialize
    @puppy_inventory = {}
    @purchase_requests = {}

    end

    def add_breed(breed, price)
      @puppy_inventory[breed] = {:price => price, :list => []}
    end

    def add_inventory(puppy)
      if @puppy_inventory[puppy.breed] == nil 
        raise "Puppy breed doesn't exist"
      else
        @puppy_inventory[puppy.breed][:list] << puppy
      end
    end
    
    def submit_purchase_request(breed)
      request = PuppyBreeder::PurchaseRequest.new(breed, self)
    end
  end
end


