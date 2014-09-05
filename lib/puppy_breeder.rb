# we initialize the module here to use in our other files

module PuppyBreeder
  #getter
  #setter
  def puppy_repo
    @puppy_repo
  end

  def puppy_repo=(x)
    @puppy_repo = x
  end

  def request_repo
    @request_repo
  end

  def request_repo=(x)
    @request_repo = x
  end
end

require_relative 'puppy_breeder/entities/puppy.rb'
require_relative 'puppy_breeder/entities/purchase_request.rb'
require_relative 'puppy_breeder/databases/puppy_repo.rb'
require_relative 'puppy_breeder/databases/request_repo.rb'

PuppyBreeder.puppy_repo = PuppyBreeder::Repos.Inventory.new
PuppyBreeder.request_repo = PuppyBreeder::Repos.RequestLog.new

