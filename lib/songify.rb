require 'pry-byebug'
module Songify
  # songs repo setter method
  def self.songs_repo=(x)
    @songs_repo = x
  end

  # songs repo getter method
  def self.songs_repo
    @songs_repo
  end

  # genres repo setter method
  def self.genres_repo=(x)
    @genres_repo = x
  end

  # genres repo getter method
  def self.genres_repo
    @genres_repo
  end
end

require_relative 'songify/entities/song.rb'
require_relative 'songify/repositories/songs.rb'
require_relative 'songify/entities/genre.rb'
require_relative 'songify/repositories/genres.rb'

Songify.genres_repo = Songify::Repositories::Genres.new("songify_dev")
Songify.songs_repo = Songify::Repositories::Songs.new("songify_dev")