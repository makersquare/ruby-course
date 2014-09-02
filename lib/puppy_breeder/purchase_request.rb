#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_accessor :status
    attr_reader :breed, :id

# Counter for request_id.
    @@counter = 0

# Initializes with breed, request_id, and request_status.
# request_status can be "Pending", "Approved", or "Denied".
    def initialize(breed, status="Pending")
      @breed = breed
      @status = status
      @@counter += 1
      @id = @@counter
    end

  end
end