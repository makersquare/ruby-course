module PuppyBreeder
  class Breeder
    attr_accessor :puppy_inventory, :purchase_requests
    
    def initialize
    @puppy_inventory = {}
    @purchase_requests = {}

    end

    def add_inventory(new_puppy)
      if @puppy_inventory[new_puppy.breed] == nil 
        @puppy_inventory[new_puppy.breed] = [new_puppy]
      else
        @puppy_inventory[new_puppy.breed].push(new_puppy)
      end
    end
    

  end
end


# Breeder.add_puppy(Puppy.new(params))