module Songify
  class Song
    attr_reader :title, :artist, :album, :genre_id, :id

    def initialize(title, artist, album, genre_id=nil)
      @title = title
      @artist = artist
      @album = album
      @genre_id = genre_id
    end
  end
end