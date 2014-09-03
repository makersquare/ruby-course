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
    # def approve_request 
    #   @status = "Approved"
    # end

    # Nick's
    def accepted!
      @status = "Accepted"
    end

# Denies purchase request and changes status to Denied.
    def deny_request
      @status = "Denied"
    end

# Nick's:
    def pending?
      @status == "Pending"
    end

    def accepted?
      @status == "Accepted"
    end

  end
end    