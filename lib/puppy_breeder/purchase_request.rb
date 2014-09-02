#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_accessor :breed, :purchaser_id
    def initialize(breed)
      @counter = 0
      @breed = breed
      @purchaser_id = @counter += 1
    end

  end

  class Purchasecontainer
    def initialize(request_id)
      @request_id = request_id
    end

  end
end