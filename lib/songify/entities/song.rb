module Songify
  class Song
    attr_accessor :title, :artist, :album, :id, :genre_id
    def initialize(title, artist, album, genre_id=nil)
      @title = title
      @artist = artist
      @album = album
      @genre_id = genre_id
    end
  end
end
