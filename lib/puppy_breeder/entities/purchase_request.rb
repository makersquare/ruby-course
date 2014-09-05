#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_reader :breed
    attr_accessor :status

    def initialize(breed)
      @breed = breed
      @status = 'pending'
    end

    def complete!
      @status = 'complete'
    end

    def completed?
      return true if @status == 'complete'
      false
    end

    def hold?
      return true if @status == 'hold'
      false
    end

    def hold!
      @status = 'hold'
    end

    def pending?
      return true if @status == 'pending'
    end
  end
end