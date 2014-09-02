# we initialize the module here to use in our other files
module PuppyBreeder

	class Inventory

		attr_accessor :inventory_hash

		def initialize
			@inventory_hash = Hash.new
		end

		def add_breed_price(breed, price)
			inventory_hash[breed] = {
				:price => price,
				:puppies =>[]
			}
		end

		def add_puppy_to_inventory(puppy)
			inventory_hash[puppy.breed][:puppies] << puppy
		end
	end
end

require_relative 'puppy_breeder/puppy.rb'
require_relative 'puppy_breeder/purchase_request.rb'
