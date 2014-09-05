# we initialize the module here to use in our other files
module PuppyBreeder

	def self.request_repo=(x)
		@request_repo = x
	end

	def self.request_repo
		@request_repo
	end

	def self.inventory_repo=(x)
		@inventory_repo = x
	end

	def self.inventory_repo
		@inventory_repo
	end
end

require_relative 'puppy_breeder/entities/puppy.rb'
require_relative 'puppy_breeder/entities/purchase_request.rb'
require_relative 'puppy_breeder/databases/inventory_repo.rb'
require_relative 'puppy_breeder/databases/purchaseorderarray.rb'

PuppyBreeder.request_repo = PuppyBreeder::Repos::PurchaseOrderArray.new
PuppyBreeder.inventory_repo = PuppyBreeder::Repos::Inventory.new