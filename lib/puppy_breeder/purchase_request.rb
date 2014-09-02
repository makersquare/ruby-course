#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_accessor :breed, :purchase_orders

    @@purchase_orders = [ ]

    def initialize(breed)
      @breed = breed

      @@purchase_orders.push(self)
    end

    def self.purchase_orders
      @@purchase_orders
    end
  end
end