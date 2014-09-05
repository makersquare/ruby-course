require 'pg'  

module PuppyBreeder
  module Repos
    class PurchaseOrderArray

    	attr_accessor :purchase_array

    	def initialize
    		@purchase_array = []
    	end

    	def add_purchase_request(purchase_request)
    		purchase_array << purchase_request
    	end

      def review_new_orders
        purchase_array.select do |purchase_req|
          purchase_req.status == "pending"
        end
      end

      def change_status(purchase_request, new_status)
        purchase_array.each do |pr|
          pr.status = new_status if purchase_request == pr
        end
      end

      def review_orders_on_hold
        purchase_array.select do |purchase_req|
          purchase_req.status == "hold"
        end
      end

      def review_all_orders_not_on_hold
         purchase_array.select do |purchase_req|
          purchase_req.status != "hold"
        end
      end

      def review_completed_orders
        purchase_array.select do |purchase_req|
          purchase_req.status == "completed"
        end
      end
    end
  end
end