require 'pry-byebug'
require 'pg'

module PuppyBreeder
  module Repos
    class RequestRepo

# Connects to puppy-breeder-db database.
      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'puppy-breeder-db')
        build_tables
      end

# Builds requests table
      def build_tables
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS requests(
            id SERIAL,
            breed TEXT,
            status TEXT
          );
        ])
      end

# Resets requests table for testing.
      def drop_and_rebuild_tables
        @db.exec(%q[
          DROP TABLE IF EXISTS requests;
        ])
        build_tables
      end

# Helper method. Builds the request for the requests database entries.
      def build_request(entries)
        entries.map do |request|
          req = PuppyBreeder::Request.new(request["breed"])
          req.instance_variable_set :@id, request["id"].to_i
          req.instance_variable_set :@status, request["status"]
          req
        end
      end

# Returns the data from the requests table.
      def log
        result = @db.exec('SELECT * FROM requests;')
        build_request(result.entries)
      end

# Adds an instance of Request into the requests table.
      def add_request(request)
      
        # Checks if request should be automatically put on hold.
        pups_available = puppies_available(request.breed)
        if pups_available.empty?
          request.on_hold!
        end

        @db.exec(%q[
          INSERT INTO requests (breed, status)
          VALUES ($1, $2);
        ], [request.breed, request.status])
      end

# Returns the puppies available for a given breed.
      def puppies_available(breed)
        PuppyBreeder::puppy_repo_instance.log.select { |puppy| puppy.breed == breed }
      end

# COMPLETED REQUESTS (Approved or Denied).
      def show_completed_requests
        completed = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'Approved' OR status = 'Denied';
        ])
        build_request(completed.entries)
      end

# CURRENT REQUESTS (Pending or On Hold)
    def show_current_requests
        current = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'Pending' OR status = 'On Hold';
        ])
        build_request(current.entries)
      end

# PENDING REQUESTS
      def show_pending_requests
        pending = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'Pending';
        ])
        build_request(pending.entries)
      end

# APPROVED REQUESTS
      def show_approved_requests
        approved = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'Approved';
        ])
        build_request(approved.entries)
      end

# DENIED REQUESTS
      def show_denied_requests
        denied = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'Denied';
        ])
        build_request(denied.entries)
      end

# HELD REQUESTS
      def show_hold_requests
        holds = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'On Hold';
        ])
        # holds.sort_by! { |request| request.id }
        build_request(holds.entries)
      end

# All current requests by the breed.
      def current_requests_of_a_breed(breed)
        breed_requests = show_current_requests
        breed_requests.select { |puppy| puppy.breed == breed }
      end

    end
  end
end