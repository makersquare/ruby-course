#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_reader :breed
    @@orders = []

    def initialize(breed)
      @breed = breed
      @@orders << self
    end

    def self.orders
      @@orders
    end
  end
end