require 'pg'
require 'pry-byebug'

module PuppyBreeder
  module Repos
    class RequestRepo

      def initialize
        @db = PG.connect(host: 'localhost', dbname: 'puppy-breeder')
        build_tables
      end

      def build_tables
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS requests (
            id serial,
            breed text,
            status text
            )
          ])
      end

      def drop_and_rebuild
        @db.exec(%q[
            DROP TABLE requests;
          ])
        build_tables
      end

      # @@purchase_orders = []

      # PG READY
      def store_purchase_orders(request)
      #   @@purchase_orders << purchase_request
        result = @db.exec(%q[
          INSERT INTO requests (breed, status)
          VALUES ($1, $2)
          RETURNING id;
        ], [request.breed, request.status])
        request.instance_variable_set :@id, result.entries.first["id"]
      end


      # MAYBE PG READY
      def review_order_status(po)
        pups_available = PuppyBreeder.puppy_repo.puppies.select { |p| p.breed == po.breed }

        if pups_available.empty?
          po.on_hold!
          # binding.pry
        else
          po.complete!
          pups_available.first.purchased!
        end

        @db.exec(%q[
          UPDATE requests SET status = $1 WHERE id = $2;
        ], [po.status, po.id])

      end
    
      # PG READY
      def purchase_orders
        # @@purchase_orders
        result = @db.exec('SELECT* FROM requests;')
        build_request(result.entries)
      end

      # PG READY
      def complete_orders
        # @@purchase_orders.select { |p| p.complete? }
        result = @db.exec(%q[
            SELECT * FROM requests WHERE status = 'complete';
          ])
        build_request(result.entries)
      end

      # PG READY
      def active_orders
        # @@purchase_orders.select {|p| !p.on_hold?}
        result = @db.exec(%q[
            SELECT * FROM requests WHERE status != 'on_hold';
          ])
        build_request(result.entries)
      end

      # PG READY
      def waitlist
        # waitlist = @@purchase_orders.select {|p| p.on_hold? }
        result = @db.exec(%q[
            SELECT * FROM requests WHERE status = 'on_hold';
          ])
        build_request(result.entries)
      end

      # PG READY
      def build_request(entries)
        entries.map do |req|
          x = PuppyBreeder::PurchaseRequest.new(req['breed'], req['status'].to_sym)
          x.instance_variable_set :@id, req['id'].to_i
          x
        end
      end

    end
  end
end
