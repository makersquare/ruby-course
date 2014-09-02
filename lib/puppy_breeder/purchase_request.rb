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

  end

end