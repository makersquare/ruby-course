#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_reader :breed, :id, :method
    attr_accessor :status

    #@@counter = 1

    def initialize(breed)
      @breed = breed
      @status = :pending
      @id = nil
      #@@counter += 1
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

    def self.completed_orders
      Requests.completed_purchase_orders
    end
  end
end