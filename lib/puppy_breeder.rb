# we initialize the module here to use in our other files
module PuppyBreeder

  attr_accessor :puppies, :purchase_orders

  @@purchase_orders = []
  @@puppies = {}

  def self.add_breed_to_hash(puppy, price)
    @@puppies[puppy.breed] = {
      :price => price,
      :list => []
    }
  end



  def self.set_breed_price(puppy,price)
    @@puppies[puppy.breed][:price] = price
  end

  def self.add_puppy_to_hash(puppy)
    if @@puppies[puppy.breed]
      @@puppies[puppy.breed][:list] += [puppy]
    else
      @@puppies[puppy.breed][:list] = puppy
    end
  end

  def self.store_purchase_orders(purchase_order)
    @@purchase_orders << purchase_order
  end

  def self.puppies
    @@puppies
  end

end

require_relative 'puppy_breeder/puppy.rb'
require_relative 'puppy_breeder/purchase_request.rb'






