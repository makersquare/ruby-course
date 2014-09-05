module PAWS

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

  def self.breed_repo=(x)
    @breed_repo = x
  end

  def self.breed_repo
    @breed_repo
  end

end

require_relative 'app/databases/puppy_repo.rb'
require_relative 'app/databases/request_repo.rb'
require_relative 'app/databases/breed_repo.rb'

require_relative 'app/entities/puppy.rb'
require_relative 'app/entities/request.rb'
require_relative 'app/entities/breed.rb'

PAWS.request_repo = PAWS::Repos::RequestRepo.new
PAWS.puppy_repo = PAWS::Repos::PuppyRepo.new
PAWS.breed_repo = PAWS::Repos::BreedRepo.new