module Songify
  class Song 
    attr_accessor :artist, :title, :album, :length, :id, :genre_id
    def initialize(artist,title,album=nil,length=3,genre_id=nil)
      @artist = artist
      @title = title
      @album = album
      @length = length
      @id = nil
      @genre_id = genre_id
    end


  end
end
