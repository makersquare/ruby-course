#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_reader :breed
    attr_accessor :status
    @@orders = []

    def initialize(breed)
      @breed = breed
      @@orders << self
      @status = 'pending'
    end

    def self.orders
      @@orders
    end

    def complete_order
      @status = 'complete'
    end

    def completed?
      return true if @status == 'complete'
      false
    end
  end
end