#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_accessor :request_status
    attr_reader :breed, :request_id

# Counter for request_id.
    @@request_counter = 0

# Initializes with breed, request_id, and request_status.
# request_status can be "Pending", "Approved", or "Denied".
    def initialize(breed, request_status="Pending")
      @breed = breed
      @@request_counter += 1
      @request_id = @@request_counter
      @request_status = request_status
    end

  end
end