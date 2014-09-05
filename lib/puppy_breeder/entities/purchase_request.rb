#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_accessor :breed, :status, :id

    def initialize(breed, status=:pending, id=nil)
      @breed = breed
      @status = status
      @id = id
    end

    def pending?
      @status == :pending
    end

    def complete?
      @status == :complete
    end

    def complete!
      @status = :complete
    end

    def on_hold!
      @status = :on_hold
    end

    def on_hold?
      @status == :on_hold
    end

  end
end