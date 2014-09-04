# we initialize the module here to use in our other files
module PuppyBreeder

  def self.puppy_repo=(x)
    @puppy_repo = x
  end

  def self.puppy_repo()
    @puppy_repo
  end

  def self.request_repo=(x)
    @request_repo = x
  end

  def self.request_repo()
    @request_repo
  end

end

require_relative 'puppy_breeder/entities/puppy.rb'
require_relative 'puppy_breeder/entities/purchase_request.rb'
require_relative 'puppy_breeder/databases/puppyManager.rb'
require_relative 'puppy_breeder/databases/Requestmanager.rb'

PuppyBreeder.puppy_repo = PuppyBreeder::Repos::PuppyManager
PuppyBreeder.request_repo = PuppyBreeder::Repos::RequestManager
