require 'pg'

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
      def self.store_purchase_orders(request)
      #   @@purchase_orders << purchase_request
        @db.exec(%q[
            INSERT INTO requests (breed, status)
            VALUES ($1, $2);
            ], [request.breed, request.status])
      end



      def self.add_request(request)
        pups_available = PuppyBreeder::Repos::Puppy.log.select { |p| p.breed == request.breed }
      end


      # MAYBE PG READY
      def self.review_order_status(po)
        pups_available = PuppyBreeder::Repos::Puppy.log.select { |p| p.breed == po.breed }

        # if @@puppies[po.breed] == nil
        #   po.on_hold!
        # elsif @@puppies[po.breed][:list].empty?
        #   po.on_hold!
        # elsif @@puppies[po.breed][:list].find { |p| p.available? }
        #   po.complete!
        #   @@puppies[po.breed][:list].find { |p| p.purchased! }
        # else     
        #   po.on_hold!
        # end

        # DOES THIS WORK?

        if pups_available.empty?
          po.on_hold!
        elsif pups_available.find { |pup_status| pup_status.available? }
          po.complete!
          pups_available.purchased!
        else
          po.on_hold!
        end



        @db.exec(%q[
            INSERT INTO requests (status)
            VALUES($1, $2);
          ], [po.breed, po.status])

        @db.exec(%q[
            INSERT INTO puppies (adoption_status)
            VALUES($1);
          ], [pups_available.status])

      end
    
      # PG READY
      def self.purchase_orders
        # @@purchase_orders
        result = @db.exec('SELECT* FROM requests;')
        build_request(result.entries)
      end

      # PG READY
      def self.complete_orders
        # @@purchase_orders.select { |p| p.complete? }
        result = @db.exec(%q[
            SELECT * FROM requests WHERE status = 'complete';
          ])
        build_request(result.entries)
      end

      # PG READY
      def self.active_orders
        # @@purchase_orders.select {|p| !p.on_hold?}
        result = @db.exec(%q[
            SELECT * FROM requests WHERE status != 'on_hold';
          ])
        build_request(result.entries)
      end

      # PG READY
      def self.waitlist
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
          # x.instance_variable_set :@id, req["id"].to_i
          # x.instance_variable_set :@status, req["status"].to_sym
          x
        end
      end

    end
  end
end
