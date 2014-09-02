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

# Approves purchase request and changes status to Approved.
    def approve_request # Nick titled has accept!
      @status = "Approved"
    end

# Denies purchase request and changes status to Denied.
    def deny_request
      @status = "Denied"
    end

  end
end

# Nick's methods:

    # def pending?
    #   @status == "Pending"
    # end

    # def accepted?
    #   @status == "Accepted"
    # end

    # def accepted!
    #   @status = "Accepted"
    # end