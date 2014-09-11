module Songify
  class Song
    attr_accessor :title, :artist, :album, :id, :genre_id
    def initialize(title, artist, album, id=nil, genre_id=nil)
      @title = title
      @artist = artist
      @album = album
      @id = id
      @genre_id = genre_id
    end
  end
end
