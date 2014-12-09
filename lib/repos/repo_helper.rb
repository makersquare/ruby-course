module PuppyBreeder
  def self.breeds_repo=(repo)
    @breeds_repo = repo
  end

  def self.breeds_repo
    @breeds_repo
  end

  def self.puppies_repo=(repo)
    @puppies_repo = repo
  end

  def self.puppies_repo
    @puppies_repo
  end

  def self.requests_repo=(repo)
    @requests_repo = repo
  end

  def self.requests_repo
    @requests_repo
  end

  def self.create_tables
    breeds_repo.create_table
    puppies_repo.create_table
    requests_repo.create_table
  end

  def self.drop_tables
    breeds_repo.drop_table
    puppies_repo.drop_table
    requests_repo.drop_table
  end
end

require_relative 'repo.rb'
require_relative 'breeds_repo.rb'
require_relative 'puppies_repo.rb'
require_relative 'requests_repo.rb'

PuppyBreeder.breeds_repo = PuppyBreeder::Repos::Breeds.new
PuppyBreeder.puppies_repo = PuppyBreeder::Repos::Puppies.new
PuppyBreeder.requests_repo = PuppyBreeder::Repos::Requests.new