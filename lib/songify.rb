require 'pry-byebug'

module Songify
  def self.songs_repo=(x)
    @songs_repo = x
  end

  def self.songs_repo
    @songs_repo
  end

  def self.genres_repo=(x)
    @genres_repo = x
  end

  def self.genres_repo
    @genres_repo
  end
end

require_relative 'songify/entities/song.rb'
require_relative 'songify/entities/genre.rb'
require_relative 'songify/repositories/songs.rb'
require_relative 'songify/repositories/genres.rb'