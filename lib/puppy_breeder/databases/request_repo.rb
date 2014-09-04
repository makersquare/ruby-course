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

      def add_order(order)
        PuppyBreeder.puppy_repo = PuppyBreeder::Repos::PuppyLog.new
        pups_available = PuppyBreeder.puppy_repo.log.select { |p| p.breed == order.breed }
        if pups_available.empty?
          order.hold!
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

      # def accept_purchase_request
      #   self.get_orders.each do |order|
      #     if PuppyBreeder::PuppyContainer.has_suitable_puppy?(order)
      #       order.complete_order
      #     end
      #   end
      # end

      def build_request(entries)
        entries.map do |req|
          x = PuppyBreeder::PurchaseRequest.new(req["breed"])
          x.instance_variable_set :@id, req["id"].to_i
          x.instance_variable_set :@status, req["status"]
          x
        end
      end
    end
  end
end