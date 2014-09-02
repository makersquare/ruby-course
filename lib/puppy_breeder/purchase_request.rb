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
        :pending => [],
        :accepted => []
      }
    end

    def purchase_request
      @@container[@breed][:pending] << @purchaser_id
    end

    def purchase_fill(purchaser_id, puppy)
      purp = @@container[@breed][:pending].shift
      @@container[@breed][:accepted] << [purp, puppy]
      puppy.status="sold"
    end
    
    def self.container
      @@container 
    end

  end
end