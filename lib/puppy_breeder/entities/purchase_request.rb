#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_accessor :breed, :status
    # :id

    # @@counter = 0

    def initialize(breed, status=:pending)
      @breed = breed
      @status = status
      # @@counter += 1
      # @id = @@counter
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