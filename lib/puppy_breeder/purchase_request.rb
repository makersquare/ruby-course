#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  
  class PurchaseRequest

  	attr_reader :breed_request
  	attr_accessor :status 

  	def initialize(breed, status="pending")
  		@breed_request = breed
  		@status = status
  	end
  end




  class PurchaseOrderArray

  	attr_accessor :purchase_array

  	def initialize
  		@purchase_array = []
  	end

  	def add_purchase_request(purchase_request)
  		purchase_array << purchase_request
  	end

    def review_new_orders
      purchase_array.select do |purchase_req|
        purchase_req.status == "pending"
      end
    end

  end

end