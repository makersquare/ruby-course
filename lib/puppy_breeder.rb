# we initialize the module here to use in our other files
module PuppyBreeder

  attr_accessor :puppies, :purchase_orders, :breed

  @@purchase_orders = []
  @@puppies = {}


  def self.add_breed_to_hash(breed, price)
    @@puppies[breed] = {
      :price => price,
      :list => []
    }
  end

  def self.change_breed_price(breed,price)
    @@puppies[breed][:price] = price
  end

  def self.add_puppy_to_hash(puppy)
    if @@puppies[puppy.breed]
      @@puppies[puppy.breed][:list] << puppy
    else
      @@puppies[puppy.breed][:list] = [puppy]
    end


  end

  def self.store_purchase_orders(purchase_request)
    @@purchase_orders << purchase_request
  end

  def self.review_order_status(po)
    if @@puppies[po.breed][:list].empty?
      po.status = "on_hold"
    else
      po.status = "complete"
    end
  end

  def self.puppies
    @@puppies
  end

  def self.purchase_orders
    @@purchase_orders
  end

  def self.select_orders_by_status(status)
    @@purchase_orders.select { |p| p.status == status }
  end

  def self.active_orders
    @@purchase_orders.select {|p| p.status == "pending" || p.status == "complete"}
  end

  def self.waitlist
    hold_orders = @@purchase_orders.select {|p| p.status == "on_hold" }
    waitlist = hold_orders.sort_by {|o| o.id}
  end

end

require_relative 'puppy_breeder/puppy.rb'
require_relative 'puppy_breeder/purchase_request.rb'






