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
    @@container = Hash.new()
    def initialize(breed, purchaser_id)
      @breed = breed
      @purchaser_id = purchaser_id
      @@container[@breed] = {
        :request => []
      }
    end

    def purchase_request
      @@container[@breed][:request] << @purchaser_id
    end
    def self.container
      @@container 
    end
  end
end