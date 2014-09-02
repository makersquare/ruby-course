#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_accessor :breed, :status


    def initialize(breed, status="pending")
      @breed = breed
      @status = status
    end


  end
end