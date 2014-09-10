module Songify

  # Songs Repo Getter Method
  def self.songs
    @songs
  end

  # Songs Repo Setter Method
  def self.songs=(x)
    @songs = x
  end

end

require_relative 'songify/entities/song.rb'
require_relative 'songify/repositories/songs.rb'

Songify.songs = Songify::Repositories::Songs.new
