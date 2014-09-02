module PuppyBreeder
  class Requests

    def self.new_request(order)
      if !defined? @purchase_orders
        @purchase_orders = []
      end

      @purchase_orders << order

    end

    def self.purchase_orders
      @purchase_orders
    end

  end
end