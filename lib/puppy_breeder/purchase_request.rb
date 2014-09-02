#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  
  class PurchaseRequest
  
    attr_reader :customer,:breed
  
    def initialize(customer,breed)
      @customer = customer
      @breed = breed
    end
  
  end

end