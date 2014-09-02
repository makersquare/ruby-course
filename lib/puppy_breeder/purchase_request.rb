#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  
  class PurchaseRequest
  
    attr_reader :customer,:breed
    attr_accessor :id
  
    def initialize(customer,breed)
      @customer = customer
      @breed = breed
      @id = nil
    end
  
  end

end