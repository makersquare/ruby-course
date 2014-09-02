#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_reader :breed
    def initialize(breed)
      @breed = breed
    end
  end
end