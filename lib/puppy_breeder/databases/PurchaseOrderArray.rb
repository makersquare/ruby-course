require 'pg'  

module PuppyBreeder
  module Repos
    class PurchaseOrderArray

    	# attr_accessor :purchase_array

    	def initialize
        @db = PG.connect(host: 'localhost', dbname: 'puppy-breeder')
    		# @purchase_array = []
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

      def drop_table
        @db.exec(%q[
          DROP TABLE requests;
        ])
        build_tables
      end

    	def add_purchase_request(purchase_request)
    		# purchase_array << purchase_request
        result = @db.exec(%q[
          INSERT INTO requests (breed, status)
          VALUES ($1, $2)
          RETURNING id;
          ], [purchase_request.breed, purchase_request.status])
        purchase_request.id = result.entries[0]['id'].to_i
    	end

      def build_request(entries)
        entries.map do |req|
          x = PuppyBreeder::PurchaseRequest.new(req["breed"])
          x.instance_variable_set :@status, req["status"]
          x.instance_variable_set :@breed, req["breed"]
          x.instance_variable_set :@id, req["id"]
          x
        end
      end

      def review_new_orders
        # purchase_array.select do |purchase_req|
        #   purchase_req.status == "pending"
        # end
        result = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'pending';
        ])
        build_request(result.entries)
      end

      def change_status(purchase_request, new_status)
        result = @db.exec(%q[
          UPDATE requests SET status = $1 WHERE id = $2;
        ], [new_status, purchase_request.id])

        # purchase_array.each do |pr|
        #   pr.status = new_status if purchase_request == pr
        # end
      end

      def review_orders_on_hold
        result = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'hold';
        ])
        build_request(result.entries)

        # purchase_array.select do |purchase_req|
        #   purchase_req.status == "hold"
        #end
      end

      def review_all_orders_not_on_hold
         result = @db.exec(%q[
          SELECT * FROM requests WHERE status != 'hold';
        ])
        build_request(result.entries)
        # purchase_array.select do |purchase_req|
        #   purchase_req.status != "hold"
        # end
      end

      def review_completed_orders
        result = @db.exec(%q[
          SELECT * FROM requests WHERE status = 'completed';
        ])
        build_request(result.entries)
        # purchase_array.select do |purchase_req|
        #   purchase_req.status == "completed"
        # end
      end
    end
  end
end