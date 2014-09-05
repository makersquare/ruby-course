#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_accessor :status, :id, :breed

    def initialize(breed)
      @breed = breed
      @status = 'pending'
    end
  end
end