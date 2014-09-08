#Refer to this class as PuppyBreeder::PurchaseRequest

module PuppyBreeder
  class PurchaseRequest
    attr_reader :breed
    attr_accessor :status, :id, :puppy_id, :price
    def initialize(breed, status="pending", id=nil)
      @breed = breed
      @status = status
      @id = id
      @puppy_id
      @price
    end



    def hold!
      @status = 'hold'
    end
#take this out if you're going to do the automatic thing
#####################################
    def approve!
      @status = 'accepted'
    end
  end
end
