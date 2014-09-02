#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    @@request_counter = 0

    def initialize(breed)
      @breed = breed
      @@request_counter += 1
      @request_if = @@request_counter
    end

  end
end