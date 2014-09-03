module PuppyBreeder
  class Requests
    @purchase_orders = []

    def self.new_request(order)
      if ForSale.for_sale[order.breed][:count] < 1
        order.status = :on_hold
      end

      @purchase_orders << order
    end

    def self.complete_request(order)
      completed_order = @purchase_orders.find {|x| x = order}
      completed_order.status = :completed
    end

    def self.pending_purchase_orders
      @purchase_orders.select {|x| x.status == :pending}
    end

    def self.completed_purchase_orders
      @purchase_orders.select {|x| x.status == :completed}
    end

    def self.purchase_orders
      @purchase_orders
    end

  end
end