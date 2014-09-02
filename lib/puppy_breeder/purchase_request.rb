#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_reader :breed
    attr_accessor :status
    @@counter = 0

    def initialize(breed)
      @breed = breed
      @status = 'pending'
      @id = @@counter
      @@counter += 1
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