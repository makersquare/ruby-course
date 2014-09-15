module Songify
  class Song
    attr_accessor :title, :artist, :album, :id
    def initialize(title, artist, album)
      @title = title
      @artist = artist
      @album = album
    end
  end
end