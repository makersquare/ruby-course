module Songify
  class Song 
    attr_accessor :artist, :title, :album, :length, :id
    def initialize(artist,title,album=nil,length=3)
      @artist = artist
      @title = title
      @album = album
      @length = length
      @id = nil
    end


  end
end
