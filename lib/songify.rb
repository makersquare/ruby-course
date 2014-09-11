module Songify

  # Songs Repo Getter Method
  def self.songs
    @songs
  end

  # Songs Repo Setter Method
  def self.songs=(x)
    @songs = x
  end

  # Genres Repo Getter Method
  def self.genres
    @genres
  end

  def self.genres=(x)
    @genres = x
  end

end

require_relative 'songify/entities/song.rb'
require_relative 'songify/repositories/songs.rb'
require_relative 'songify/entities/genre.rb'
require_relative 'songify/repositories/genres.rb'
require_relative 'songify/repositories/repositories.rb'