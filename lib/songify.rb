require 'pg'
module Songify

  def self.songs=(x)
    @songs = x
  end

  def self.songs
    @songs
  end

  def self.genres=(x)
    @genres = x
  end

  def self.genres
    @genres
  end


end

require_relative 'songify/databases/songs.rb'
require_relative 'songify/entities/song.rb'
require_relative 'songify/databases/genres.rb'
require_relative 'songify/entities/genre.rb'


Songify.songs = Songify::Repos::Songs.new
Songify.genres = Songify::Repos::Genres.new
