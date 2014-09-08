# we initialize the module here to use in our other files
module PuppyPalace
  def self.request_repo=(x)
    @request_repo = x 
  end

  def self.request_repo
    @request_repo
  end

  def self.puppy_repo=(x)
    @puppy_repo = x 
  end

  def self.puppy_repo
    @puppy_repo
  end
end

require_relative 'puppy_breeder/entities/puppy.rb'
require_relative 'puppy_breeder/entities/request.rb'
require_relative 'puppy_breeder/databases/request_repo.rb'
require_relative 'puppy_breeder/databases/puppy_repo.rb'

PuppyPalace.request_repo = PuppyPalace::Repos::PurchaseReqLog.new

PuppyPalace.puppy_repo = PuppyPalace::Repos::PuppyRepo.new