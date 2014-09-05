#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  
  class PurchaseRequest

  	attr_reader :breed_request
  	attr_accessor :status 

  	def initialize(breed, status="pending")
  		@breed_request = breed
  		@status = status
  	end

    def available?(inventory)
      if inventory.inventory_hash[breed_request][:puppies] == []
        return false
      elsif inventory.inventory_hash[breed_request][:puppies] == nil
        return false
      else
        return true
      end
    end
  end
end