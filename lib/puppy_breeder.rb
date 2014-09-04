# we initialize the module here to use in our other files
module PuppyBreeder
  def self.puppy_container
    @__db_instance ||= PuppyBreeder::PuppyContainer.new
  end

  def self.purchase_request_container
    @__db_instance2 ||= PuppyBreeder::PurchaseRequestContainer.new
  end
end

require_relative 'puppy_breeder/entities/puppy.rb'
require_relative 'puppy_breeder/entities/request.rb'
require_relative 'puppy_breeder/databases/puppy_repo.rb'
require_relative 'puppy_breeder/databases/request_repo.rb'
