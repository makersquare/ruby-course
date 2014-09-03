module PuppyBreeder
  class RequestContainer
    @@orders = []

    def self.add_order(order)
      @@orders << order
      if PuppyBreeder::PuppyContainer.has_suitable_puppy?(order)
      else
        order.put_on_hold
      end
    end

    def self.get_orders
      @@orders
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