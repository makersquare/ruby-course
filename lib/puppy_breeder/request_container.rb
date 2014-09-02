module PuppyBreeder
  class RequestContainer
    @@orders = []

    def self.add_order(order)
      @@orders << order
    end

    def self.get_orders
      @@orders
    end

    def self.get_completed_orders
      self.get_orders.select { |order| order.completed? }
    end

    def self.review_purchase_request
      self.get_orders.select { |order| !order.completed? }
    end

    def self.accept_purchase_request
      self.get_orders.each { |order| order.complete_order }
    end
  end
end