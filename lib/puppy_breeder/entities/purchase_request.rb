#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  
  class PurchaseRequest

  	attr_reader :breed 
  	attr_accessor :status, :id

  	def initialize(breed, status="pending")
  		@breed = breed
  		@status = status
      @id = nil
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