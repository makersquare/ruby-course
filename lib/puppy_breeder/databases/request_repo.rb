require 'pg'

module PuppyBreeder
  module Repos
    class Requests
      #@purchase_orders = []

      def initialize #test?
        @db = PG.connect(host: 'localhost', dbname: 'puppy-breeder')
        build_table
      end

      def build_table #test?
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS requests(
            id serial,
            breed text,
            status text
          );
        ])
      end

      def destroy #test?
        @db.exec(%q[
          DROP TABLE IF EXISTS requests;
        ])
      end

      def log
        result = @db.exec('SELECT * FROM requests ORDER BY id ASC;')
        build_request(result.entries)
      end

      def add_request(request)
        pups_available = PuppyBreeder.puppy_repo.log.select { |p| p.breed == request.breed }

        if pups_available.empty?
          request.on_hold!
        end

        @db.exec(%q[
          INSERT INTO requests (breed, status)
          VALUES ($1, $2);
        ], [request.breed, request.status])

        result = @db.exec(%q[
          SELECT * 
          FROM requests 
          ORDER BY id DESC 
          LIMIT 1
        ])

        final = build_request(result.entries)

        request.id = final.first.id
      end

      def pending_requests
        result = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'pending';
        ])
        build_request(result.entries)
      end

      def completed_requests
        result = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'completed';
        ])
        build_request(result.entries)
      end

      def hold_requests
        result = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'on_hold';
        ])
        build_request(result.entries)
      end

      def build_request(entries) #test?
        entries.map do |req|
          x = PuppyBreeder::PurchaseRequest.new(req["breed"])
          x.instance_variable_set :@id, req["id"].to_i
          x.instance_variable_set :@status, req["status"].to_sym
          x
        end
      end

      def update_request_status(request)
        @db.exec(%q[
          UPDATE requests SET status = $1 WHERE id = $2;
        ], [request.status, request.id])
      end

      # def self.complete_request(order)
      #   completed_order = @purchase_orders.find {|x| x = order}
      #   completed_order.status = :completed
      # end

      # def self.hold_to_pending(order)
      #   to_pending = @purchase_orders.find {|x| x = order}
      #   to_pending.first.status = :pending if !to_pending.nil?
      # end
    end
  end
end