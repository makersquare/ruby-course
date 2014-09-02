# we initialize the module here to use in our other files
module PuppyBreeder

	class Inventory

		attr_accessor :inventory_hash, :breed_price

		def initialize
			@inventory_hash = {}
			@breed_price = {}
		end

		def update_breed_price(breed, price)
			breed_price[:price] = price
		end

	end
end

require_relative 'puppy_breeder/puppy.rb'
require_relative 'puppy_breeder/purchase_request.rb'
