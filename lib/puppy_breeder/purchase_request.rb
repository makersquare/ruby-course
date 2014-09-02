#Refer to this class as PuppyBreeder::PurchaseRequest

module PuppyBreeder
  class PurchaseRequest
    @@counter = 0
    attr_reader :breed, :request_id, :status
    def initialize(breed, status="pending")
      @breed = breed
      @status = status
      @request_id = @@counter += 1
    end
  end
end
