require 'pg'

module PuppyPalace
  module Repos
    class PurchaseReqLog
      attr_reader :id

      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'puppy-breeder')
        # build_tables
      end
      
      def build_request(entries)
        entries.map do |req|
          r = PuppyPalace::PurchaseRequest.new(req["breed"])
          r.instance_variable_set :@id, req["id"].to_i
          r.instance_variable_set :@status, req["status"].to_sym
          r
        end
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
          DROP TABLE IF EXISTS requests
          ])
      end

      def open_orders
        result = @db.exec('SELECT * FROM requests')
        build_request(result.entries)
      end

      def add_request(request)
        @db.exec(%q[
          INSERT INTO requests(breed,status)
          VALUES ($1,$2);
          ], [request.breed,request.status])
      end

      def show_req
        reult = @db.exec(%w[
          SELECT * FROM requests WHERE status = 'pending';
          ])
        build_request(result.entries)
      end

      def find_request(id)
        result = @db.exec(%q[
          SELECT * FROM requests WHERE id = $1;
          ], [id])
        PuppyPalace::PurchaseRequest.new(result.first["breed"])
      end

      def show_orders
        result = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'accepted';
          ])
        build_request(result.entries)
      end

      def show_exclude_hold
        result = @db.exec(%q[
          SELECT * FROM requests WHERE NOT status = 'on_hold';          
          ])
        build_request(result.entries)
      end

      def accept!(order_id)
        x = @db.exec(%q[
          UPDATE requests SET status = 'accepted' WHERE id = $1;
          ], [order_id])
      end

      def hold!(order_id)
        x = @db.exec(%q[
          UPDATE requests SET status = 'on_hold' WHERE id = $1;
          ], [order_id])
      end

      def show_hold
        result = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'on_hold';          
          ])
        build_request(result.entries)
      end

      def reject!(order_id)
        x = @db.exec(%q[
          UPDATE requests SET status = 'rejected' WHERE id = $1;
          ], [order_id])
      end
    end
  end
end