require 'pry-byebug'
#Refer to this class as PuppyBreeder::PurchaseRequest
module PuppyBreeder
  class PurchaseRequest
    attr_accessor :breed, :status, :id_count, :id_num, :open_orders, :completed_orders

    @@id_count = 0
    @@open_orders = { }

    def initialize(breed,status='pending',id_num=@id_count)
      @breed = breed
      @status = status
      @id_num = @@id_count
      @@id_count += 1

      @@open_orders[@id_num] = self
    end

    def self.open_orders
      @@open_orders 
    end

    def self.accept(order_id)
      @@open_orders[order_id].status = 'accepted'
    end

    def self.reject(order_id)
      @@open_orders[order_id].status = 'rejected'
    end

    def self.hold(order_id)
      @@open_orders[order_id].status = 'hold'
    end

    def self.orders
      @@open_orders.select { |k,v| v.status == 'accepted' || v.status == 'rejected' || v.status == 'pending' }
    end

    def self.completed
      @@open_orders.select { |k,v| v.status == 'accepted' }
    end
  end
end