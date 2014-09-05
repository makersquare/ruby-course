require 'pg'

module PuppyBreeder
	module Repos
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
				if inventory_hash[puppy.breed]
					inventory_hash[puppy.breed][:puppies] << puppy
				else
					raise "Error no breed for puppy!"
				end
			end
		end
	end
end