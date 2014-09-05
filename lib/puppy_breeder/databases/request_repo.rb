require 'pg'

module PuppyBreeder
  module Repos
    class RequestLog

      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'puppy-breeder')
        build_tables
      end

      def build_tables
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS requests(
            id serial,
            breed text,
            status text
          )
        ])
      end

      def drop_tables
        @db.exec(%q[
          DROP TABLE requests;
        ])
        build_tables
      end

      def add_purchase_request(request)
        pups_available = PuppyBreeder.puppy_repo.log.select { |p| p.breed == request.breed }
        if pups_available.empty?
          request.status = 'hold'
        end

        result = @db.exec(%q[
          INSERT INTO requests (breed, status)
          VALUES ($1, $2)
          RETURNING id;
        ], [request.breed, request.status])
        request.instance_variable_set("@id", result[0]["id"])
      end

      def log
        result = @db.exec("SELECT * FROM requests;")
        build_request(result.entries)
      end

      def get_completed_requests
        result = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'complete';
        ])
        build_request(result.entries)
      end

      def review_purchase_request
        result = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'pending';
        ])
        build_request(result.entries)
      end

      def accept_purchase_request(request)
        @db.exec(%q[
          UPDATE requests SET status = 'complete' WHERE id = $1;
        ], [request.id])
      end

      def build_request(entries)
        entries.map do |req|
          x = PuppyBreeder::PurchaseRequest.new(req["breed"])
          x.instance_variable_set :@status, req["status"]
          x.instance_variable_set :@id, req["id"].to_i
          x
        end
      end
    end
  end
end