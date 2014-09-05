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

      def add_order(order)
        pups_available = PuppyBreeder.puppy_repo.log.select { |p| p.breed == order.breed }
        if pups_available.empty?
          order.status = 'hold'
        end

        @db.exec(%q[
          INSERT INTO requests (breed, status)
          VALUES ($1, $2);
        ], [order.breed, order.status])
      end

      def log
        result = @db.exec("SELECT * FROM requests;")
        build_request(result.entries)
      end

      def get_completed_orders
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

      def accept_purchase_request
        @db.exec(%q[
          UPDATE requests SET status = 'complete' WHERE status = 'pending';
        ])
      end

      def build_request(entries)
        entries.map do |req|
          x = PuppyBreeder::PurchaseRequest.new(req["breed"])
          x.instance_variable_set :@status, req["status"]
          x
        end
      end
    end
  end
end