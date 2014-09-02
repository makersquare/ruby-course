#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_reader :breed, :id, :method
    attr_accessor :status

    @@counter = 1

    def initialize(breed, method = :by_customer)
      @breed = breed
      @method = method
      @status = :pending
      @id = @@counter
      @@counter += 1
      Requests.new_request(self)
    end

    def self.review
      # ForSale.for_sale
      Requests.pending_purchase_orders
    end

    def accept
      @status = :completed
      Requests.complete_request(self)
      ForSale.purchase(self.breed)
    end 
  end
end