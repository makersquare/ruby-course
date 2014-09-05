#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_reader :breed
    attr_accessor :status, :id

    def initialize(breed)
      @breed = breed
      @status = :pending
      @id = nil
    end

    def accept!
      @status = :completed
    end 

    def on_hold!
      @status = :on_hold
    end
  end
end