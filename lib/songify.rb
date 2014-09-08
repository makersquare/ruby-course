module Songify

  def self.songs=(x)
    @songs = x
  end

  def self.songs
    @songs
  end

  # def self.puppy_repo=(x)
  #   @puppy_repo = x
  # end

  # def self.puppy_repo
  #   @puppy_repo
  # end

  # def self.breed_repo=(x)
  #   @breed_repo = x
  # end

  # def self.breed_repo
  #   @breed_repo
  # end

end

require_relative 'songify/databases/songs.rb'
# require_relative 'app/databases/request_repo.rb'
# require_relative 'app/databases/breed_repo.rb'

require_relative 'songify/entities/song.rb'
# require_relative 'app/entities/request.rb'
# require_relative 'app/entities/breed.rb'

Songify.songs = Songify::Repos::Songs.new
# PAWS.puppy_repo = PAWS::Repos::PuppyRepo.new
# PAWS.breed_repo = PAWS::Repos::BreedRepo.new