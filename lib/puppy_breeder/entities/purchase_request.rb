#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_reader :breed
    attr_accessor :status

    def initialize(breed)
      @breed = breed
      @status = 'pending'
    end
  end
end