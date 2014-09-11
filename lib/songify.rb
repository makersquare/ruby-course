module Songify

  def self.songs_repo=(x)
    @songs_repo = x
  end

  def self.songs_repo
    @songs_repo
  end

end

require_relative 'entities/song.rb'
require_relative 'repositories/songs.rb'
require_relative 'entities/genre.rb'
require_relative 'repositories/genres.rb'


Songify.songs_repo = Songify::Repositories::Songs.new