#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_reader :breed, :status, :id

    @@counter = 1

    def initialize(breed)
      @breed = breed
      @status = :pending
      @id = @@counter
      @@counter += 1
    end

    def accept
      @status = :completed
    end 
  end
end