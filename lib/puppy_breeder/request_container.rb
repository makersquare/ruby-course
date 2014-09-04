module PuppyBreeder
  module Repos
    class RequestContainer
      # @@orders = []

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

      def self.add_order(order)
        @@orders << order
        if PuppyBreeder::PuppyContainer.has_suitable_puppy?(order)
        else
          order.put_on_hold
        end
      end

      def log
        result = @db.exec("SELECT * FROM requests;")
        result.entries.map do |req_hash|
          x = PuppyBreeder::PurchaseRequest.new(req_hash["breed"])
          x.instance_variable_set :@id, req_hash["id"].to_i
          x.instance_variable_set :@status, req_hash["status"]
          x
        end
      end

      def self.get_completed_orders
        self.get_orders.select { |order| order.completed? }
      end

      def self.review_purchase_request
        self.get_orders.select { |order| !order.completed?  && !order.hold? }
      end

      def self.accept_purchase_request
        self.get_orders.each do |order|
          if PuppyBreeder::PuppyContainer.has_suitable_puppy?(order)
            order.complete_order
          end
        end
      end
    end
  end
end