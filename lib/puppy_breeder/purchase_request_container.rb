#Refer to this class as PuppyBreeder::PurchaseRequestContainer
module PuppyBreeder
  class PurchaseRequestContainer

    # Refactored
    @@requests = []
    @@accepted_requests = []

# Access requests
    # attr_accessor :requests

# Initiailizes with requests hash. Has three keys: "Pending", "Approved", "Denied".
    # def initialize
    #   @requests = Array.new
    # end

# Add an instance of PurchaseRequest into the requests hash with a key of the status.
    # def add_request(request)
    #   @requests << request
    # end

    # Refactored
    def self.add_request(request)
      @@requests << request
    end

# Displays all completed requests.
    # def completed_requests
    #   @requests.select do |request| 
    #     request.status == "Approved" || request.status == "Denied"
    #   end
    # end

    # Refactored
    def self.show_completed_requests
      @@requests.select { |request| request.accepted? }
    end

# Displays all pending requests.
    # def pending_requests
    #   @requests.select do |request| 
    #     request.status == "Pending"
    #   end
    # end

    # Refactored
    def self.show_pending_requests
      @@requests.select { |request| request.pending? }
    end

# Displays all approved requests.
    # def approved_requests
    #   @requests.select do |request| 
    #     request.status == "Approved"
    #   end
    # end

# Displays all denied requests.
    # def denied_requests
    #   @requests.select do |request| 
    #     request.status == "Denied"
    #   end
    # end

# Displays all requests by the breed.
    # def requests_of_a_breed(breed)
    #   @requests.select do |request|
    #     request.breed == breed
    #   end
    # end

  end
end