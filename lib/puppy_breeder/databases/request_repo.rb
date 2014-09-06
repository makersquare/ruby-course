require 'pg'

module PuppyBreeder
  module Repos
    class Requests

      def initialize 
        @db = PG.connect(host: 'localhost', dbname: 'puppy-breeder')
        build_table
      end

      def build_table 
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS requests(
            id serial,
            breed text,
            status text
          );
        ])
      end

      def destroy_and_rebuild 
        @db.exec(%q[
          DROP TABLE IF EXISTS requests;
        ])
        build_table
      end

      def log
        result = @db.exec('SELECT * FROM requests ORDER BY id ASC;')
        build_request(result.entries)
      end

      def add_request(request)
        build_table
        pups_available = PuppyBreeder.puppy_repo.log.select { |p| p.breed == request.breed }

        if pups_available.empty?
          request.on_hold!
        end

        result = @db.exec(%q[
          INSERT INTO requests (breed, status)
          VALUES ($1, $2)
          RETURNING id;
        ], [request.breed, request.status])

        request.id = result.entries.first["id"].to_i
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

      def build_request(entries) 
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

      def update_holds
        hold_requests = PuppyBreeder.request_repo.log.select { |req| req.status == :on_hold}

        puppies = PuppyBreeder.puppy_repo.log.select { |pup| pup.availability == :for_sale}

        puppies.each do |pup|
          result = hold_requests.find {|req| req.breed == pup.breed}
          if result
            hold_requests.delete(result)
            result.pending!
            update_request_status(result)
          end
        end
      end

      # def self.hold_to_pending(order)
      #   to_pending = @purchase_orders.find {|x| x = order}
      #   to_pending.first.status = :pending if !to_pending.nil?
      # end
    end
  end
end