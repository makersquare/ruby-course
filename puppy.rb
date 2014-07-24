module PuppyMill

  class Puppy
    attr_reader :breed, :name, :age
    def initialize(args)
      @breed = args[:breed]
      @name = args[:name]
      @age = args[:age]
    end

  end

  class Puppies
    @all_pups = {}

    def self.add_pup(puppy, klass=PuppyMill::PurchaseOrders)
      klass.modify_hold_orders(puppy)
      @all_pups.has_key?(puppy.breed) ? (@all_pups[puppy.breed][:list] << puppy) : (@all_pups[puppy.breed] = {price: :unknown, list: [puppy]})
    end

    def self.all_pups
      @all_pups
    end

    def self.breed_available?(breed)
      @all_pups.has_key?(breed)
    end
  end

  class PurchaseOrder
    attr_reader :customer_name, :breed, :id
    @@id = 0

    def initialize(args)
      @customer_name = args[:customer_name]
      @breed = args[:breed]
      @status = :pending
      @id = @@id+=1
    end

    def status
      @status
    end

    def status=(new_status)
      @status = new_status
    end

    def pend!
      @status = :pending
    end

    def pending?
      @status == :pending
    end

    def hold!
      @status = :hold
    end

    def hold?
      @status == :hold
    end

    def accepted?
      @status == :accepted
    end

    def accept!
      @status = :accepted
    end

    def denied?
      @status == :denied
    end

    def deny!
      @status = :denied
    end

    def review
      "customer: #{customer_name}, puppy breed: #{breed}"
    end
  end

  class PurchaseOrders
    @orders = []

    def self.orders
      @orders
    end

    def self.add_order(order)
      order.status = :hold unless fulfill_order?(order)
      @orders << order
    end

    def self.accept(accepted_order)
      @orders = @orders.each {|order| order.accept! if order == accepted_order}
    end

    def self.deny(denied_order)
      @orders = @orders.each {|order| order.deny! if order == denied_order}
    end

    def self.view_all_accepted_orders
      @orders.select {|order| order.accepted?}
    end

    def self.view_all_pending_orders
      @orders.select {|order| order.pending?}.sort_by {|order| order.id}
    end

    ##### Helper Methods #####

    def self.fulfill_order?(klass=PuppyMill::Puppies, order)
      return true if klass.breed_available?(order.breed)
    end

    def self.modify_hold_orders(puppy)
      unless @orders.empty?
        new_pending_orders = @orders.select {|order| puppy.breed == order.breed}.each {|o| o.pend!}
        delete_old_orders(new_pending_orders)
        prioritize_hold_to_front_of_pending(new_pending_orders)
      end
    end

    def self.delete_old_orders(new_pending_orders)
      @orders = @orders.delete_if {|order| new_pending_orders.include?(order)}
    end

    def self.prioritize_hold_to_front_of_pending(new_pending_orders)
      @orders = (new_pending_orders << @orders).flatten
    end
  end
end

# spot = PuppyMill::Puppy.new(name: 'Spot', age: 100, breed: 'dalmation')
# rex = PuppyMill::Puppy.new(name: 'Rex', age: 250, breed: 'great dane')
#
# order1 = PuppyMill::PurchaseOrder.new(customer_name: 'Austin', breed: 'dalmation')
# order2 = PuppyMill::PurchaseOrder.new(customer_name: 'Joe', breed: 'great dane')
#
# PuppyMill::PurchaseOrders.add_order(order2)
# PuppyMill::PurchaseOrders.add_order(order1)
#
# puts "order 1 status: #{order1.status}"
#
#
# puts PuppyMill::PurchaseOrders.orders
#
# # PuppyMill::Puppies.add_pup(spot)
# # PuppyMill::Puppies.add_pup(rex)
# PuppyMill::PurchaseOrders.modify_hold_orders(rex)
# PuppyMill::PurchaseOrders.modify_hold_orders(spot)
# puts "order1 status: #{order1.status}"
# puts "order2 status: #{order2.status}"
# puts PuppyMill::PurchaseOrders.orders
