# we initialize the module here to use in our other files
module PuppyBreeder

# Creates single instance of Puppy Container
  def self.puppy_container
    @__db_instance ||= PuppyBreeder::Repos::PuppyContainer.new
  end

# Creates single instance of Purchase Request Container
  def self.purchase_request_container
    @__db_instance2 ||= PuppyBreeder::Repos::PurchaseRequestContainer.new
  end

# Getter method for request repo
  def self.request_repo
    @request_repo
  end

# Setter method for request repo
  def self.request_repo=(x)
    @request_repo = x
  end

end

require_relative 'puppy_breeder/entities/puppy.rb'
require_relative 'puppy_breeder/entities/request.rb'
require_relative 'puppy_breeder/databases/puppy_repo.rb'
require_relative 'puppy_breeder/databases/request_repo.rb'
