#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_accessor :breed, :status
    def initialize(breed, status=:pending)
      ###add status
      @breed = breed
      @status = status
    end
    def pending?
      @status == :pending
    end

    def accepted!
      @status = :accepted
    end

    def hold! 
      @status = :hold
    end
  end

  class Purchasecontainer
    @@container = []
    # def initialize(breed)
    #   @breed = breed
    # end
      
    def self.purchase_request(request)
      if !PuppyBreeder::Puppycontainer.pound.has_key?(request.breed)
        request.hold!
      elsif !PuppyBreeder::Puppycontainer.pound[:available].nil?
        request.hold!
      end
      @@container << request
    end
    
    def self.container
      @@container 
    end
  end
end

