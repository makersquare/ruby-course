#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_reader :breed, :status, :id, :method

    @@counter = 1

    def initialize(breed, method = :by_customer)
      @breed = breed
      @method = method
      @status = :pending
      @id = @@counter
      @@counter += 1
      Requests.new_request(self)
    end

    def review

    end

    def accept
      @status = :completed
      ForSale.purchase(self.breed)
    end 
  end
end