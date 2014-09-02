#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_reader :breed, :id
    attr_accessor :status
    @@counter = 0

    def initialize(breed)
      @breed = breed
      @status = 'pending'
      @@counter += 1
      @id = @@counter
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