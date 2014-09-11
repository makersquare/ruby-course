require 'pg'
module Songify

  def self.songs=(x)
    @songs = x
  end

  def self.songs
    @songs
  end

end

require_relative 'songify/databases/songs.rb'

require_relative 'songify/entities/song.rb'

Songify.songs = Songify::Repos::Songs.new
