#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder

  class PurchaseRequest

    def initialize(breed)
      @breed = breed
      @open_request? = true
    end

    def close_request()
    end

  end
end