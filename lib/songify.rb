module Songify
  def self.song_repo=(x)
    @song_repo = x
  end
  def self.song_repo
    @song_repo
  end

  def self.genre_repo=(x)
    @genre_repo = x
  end
  def self.genre_repo
    @genre_repo
  end
end

require_relative 'table.rb'
require_relative 'songify/entities/song.rb'
require_relative 'songify/entities/genre.rb'
require_relative 'songify/repositories/songs.rb'
require_relative 'songify/repositories/genres.rb'


Songify.song_repo = Songify::Repositories::Songs.new
Songify.genre_repo = Songify::Repositories::Genres.new