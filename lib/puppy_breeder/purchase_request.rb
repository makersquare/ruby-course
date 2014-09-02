#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_accessor :breed, :status

    # @@purchase_orders = [ ]

    def initialize(breed,status='pending')
      @breed = breed
      @status = status
      # @@purchase_orders.push(self)
    end

    # def self.purchase_orders
    #   @@purchase_orders
    # end
  end
end