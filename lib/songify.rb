require 'pg'
module Songify

  def self.genres=(x)
    @genres = x
  end

  def self.genres
    @genres
  end

  def self.songs=(x)
    @songs = x
  end

  def self.songs
    @songs
  end

end

require_relative 'songify/databases/genres.rb'
require_relative 'songify/entities/genre.rb'

require_relative 'songify/databases/songs.rb'
require_relative 'songify/entities/song.rb'


