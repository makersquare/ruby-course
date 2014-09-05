#Refer to this class as PuppyBreeder::PurchaseRequest

module PuppyBreeder
  class PurchaseRequest
    attr_reader :breed, :request_id
    attr_accessor :status
    def initialize(breed, status="pending")
      @breed = breed
      @status = status
      @request_id
    end

    def hold!
      @status = 'hold'
    end
  end
end
