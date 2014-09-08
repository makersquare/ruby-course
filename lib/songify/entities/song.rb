module Songify
  class Song
    attr_reader :title, :artist, :album, :id
    def initialize(title, artist, album, id=nil)
      @title = title
      @artist = artist
      @album = album
      @id = id
    end
  end
end
