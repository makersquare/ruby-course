#Refer to this class as PuppyBreeder::PurchaseRequestContainer
module PuppyBreeder
  class PurchaseRequestContainer

    # Refactored
    # @@requests = []
    # @@accepted_requests = []

# Access requests
    attr_accessor :requests

# Initiailizes with requests hash. Has three keys: "Pending", "Approved", "Denied".
    def initialize
      @requests = Array.new
      # @db = PG.connect(host: 'localhost', dbname: 'puppy-breeder-db')
    end

    def log
      result = @db.exec('SELECT * FROM requests;')
      result.entries.map do |req|
        x = PuppyBreeder::PurchaseRequest.new(req[breed])
        x.instance_variable_set :@id, req["id"].to_i
        x.instance_variable_set :@status, req["status"].to_sym
        x
      # result.entries will look similar to:
      # [{"id" => "3"}, {"breed" => "boxer"}, {"status" =>"pending"}]
      end
    end

# Add an instance of PurchaseRequest into the requests hash with a key of the status.
    def add_request(request)
      if !PuppyBreeder.puppy_container.breed_availability(request.breed)
        request.hold!
      end

      @requests << request
    end

    # def add_request(request)
    #   pups_available = PuppyBreeder::Repos::Puppy.log.select { |p| p.breed == request.breed }
      
    #   if pups_available.empty?
    #     request.hold!
    #   end

    #   @db.exec(%q[
    #     INSERT INTO requests (breed, status)
    #     VALUES ($1, $2);
    #   ], (request.breed, request.status))
    # end

    # Refactored
    # def self.add_request(request)
    #   @@requests << request
    # end

# Displays all completed requests.
    def completed_requests
      @requests.select do |request| 
        request.status == "Approved" || request.status == "Denied"
      end
    end

    # Refactored
    # def self.show_completed_requests
    #   @@requests.select { |request| request.accepted? }
    # end

# Displays all pending requests.
    def pending_requests
      @requests.select do |request| 
        request.status == "Pending"
      end
    end

    # Refactored
    # def self.show_pending_requests
    #   @@requests.select { |request| request.pending? }
    # end

# Displays all approved requests.
    def approved_requests
      @requests.select do |request| 
        request.status == "Approved"
      end
    end

# Displays all denied requests.
    def denied_requests
      @requests.select do |request| 
        request.status == "Denied"
      end
    end

# Held requests.
    def held_requests
      holds = @requests.select do |request|
        request.status == "Hold"
      end
      holds.sort_by! { |request| request.id }
    end

# Displays all requests by the breed.
    def requests_of_a_breed(breed)
      @requests.select do |request| d
        request.breed == breed
      end
    end

  end
end