# we initialize the module here to use in our other files
module PuppyBreeder
  def self.request_repo=(x)
    @request_repo = x
  end

  def self.request_repo
    @request_repo    
  end

  def self.puppy_repo=(x)
    @request_repo = x
  end

  def self.puppy_repo
    @request_repo    
  end
end

require_relative 'puppy_breeder/entities/puppy.rb'
require_relative 'puppy_breeder/entities/purchase_request.rb'
require_relative 'puppy_breeder/databases/puppy_repo.rb'
require_relative 'puppy_breeder/databases/request_repo.rb'

PuppyBreeder.request_repo = PuppyBreeder::Repos::Requests.new
PuppyBreeder.puppy_repo = PuppyBreeder::Repos::Puppies.new