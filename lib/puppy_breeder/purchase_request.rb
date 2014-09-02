#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_accessor :breed, :status, :id

    @@counter = 0

    def initialize(breed, status="pending", id=nil)
      @breed = breed
      @status = status
      @@counter += 1
      @id = @@counter
    end

  end
end