#Refer to this class as PuppyBreeder::PurchaseRequestContainer
module PuppyBreeder
  class PurchaseRequestContainer
    attr_accessor :requests

    def initialize
      @requests = {
        "Pending" => [],
        "Approved" => [],
        "Denied" => []
      }
    end

    def add_request(request)
      @requests[request.request_status] << request
    end

    def approve_request(request)

    end

    def deny_request(request)

    end

  end
end