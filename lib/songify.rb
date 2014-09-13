module Songify
#songs repo setter method
  def self.songs_repo=(x)
    @songs_repo = x
  end

# songs repo getter method
  def self.songs_repo
    @songs_repo
  end

  def self.genres_repo=(x)
    @genres_repo=x
  end

  def self.genres_repo
    @genres_repo
  end
end

require_relative 'songify/entities/song.rb'
require_relative 'songify/repositories/songs.rb'
require_relative 'songify/repositories/genres.rb'
require_relative 'songify/entities/genre.rb'

Songify.songs_repo = Songify::Repositories::Songs.new
Songify.genres_repo = Songify::Repositories::Genres.new



