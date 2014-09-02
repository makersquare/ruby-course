#Refer to this class as PuppyBreeder::PurchaseRequestContainer
module PuppyBreeder
  class PurchaseRequestContainer

# Access requests
    attr_accessor :requests

# Initiailizes with requests hash. Has three keys: "Pending", "Approved", "Denied".
    def initialize
      @requests = Array.new
    end

# Add an instance of PurchaseRequest into the requests hash with a key of the status.
    def add_request(request)
      @requests << request
    end

    def approve_request(request)

    end

    def deny_request(request)

    end

  end
end