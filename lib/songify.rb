module Songify

  def self.song_repo=(x)
    @song_repo = x
  end

  def self.song_repo
    @song_repo
  end


end

require_relative 'songify/entities/song.rb'
require_relative 'songify/repositories/song_repo.rb'


Songify.song_repo = Songify::Repositories::Song_Repo.new
