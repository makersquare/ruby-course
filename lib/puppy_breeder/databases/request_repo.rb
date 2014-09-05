#Refer to this class as PuppyBreeder::PurchaseRequestContainer
require 'pry-byebug'
require 'pg'

module PuppyBreeder
  module Repos
    class RequestRepo

      # Refactored
      # @@requests = []
      # @@accepted_requests = []

  # Access requests
      attr_accessor :requests

  # Initiailizes with requests hash. Has three keys: "Pending", "Approved", "Denied".
      def initialize
        # @requests = Array.new

  # Connects to puppy-breeder database:
        @db = PG.connect(host: 'localhost', dbname: 'puppy-breeder-db')
        build_tables
      end

  # Builds tables each time the request is initialized
      def build_tables
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS requests(
            id SERIAL,
            breed TEXT,
            status TEXT
          );
        ])
      end

      def drop_and_rebuild_tables
        @db.exec(%q[
          DROP TABLE IF EXISTS requests;
        ])

        build_tables
      end

  # Helper method. Builds the request for database entries.
      def build_request(entries)
        entries.map do |request|
          x = PuppyBreeder::Request.new(request["breed"])
          x.instance_variable_set :@id, request["id"].to_i
          x.instance_variable_set :@status, request["status"]
          x
        end
      end

  # Returns the data from the database.
      def log
        result = @db.exec('SELECT * FROM requests;')
        build_request(result.entries)
      end

  # Add an instance of PurchaseRequest into the requests hash with a key of the status.
      def add_request(request)
      #   if !PuppyBreeder.puppy_container.breed_availability(request.breed)
      #     request.hold!
      #   end

      #   @requests << request
      
        pups_available = PuppyBreeder.puppy_repo_instance.log.select { |p| p.breed == request.breed }
        
        if pups_available.empty?
          request.hold!
        end

        @db.exec(%q[
          INSERT INTO requests (breed, status)
          VALUES ($1, $2);
        ], [request.breed, request.status])
      end

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
      # def pending_requests
      #   @requests.select do |request| 
      #     request.status == "Pending"
      #   end
      # end

      # Refactored
      # def self.show_pending_requests
      #   @@requests.select { |request| request.pending? }
      # end

  # Displays all Pending requests.
      def show_requests
        result = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'Pending';
        ])
        build_request(result)
      end

  # Displays all approved requests.
      # def approved_requests
      #   @requests.select do |request| 
      #     request.status == "Approved"
      #   end
      # end

      def show_approved_requests
        result = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'Approved';
        ])
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
end