module Songify
  class Song
    attr_reader :title, :artist, :album, :genre, :length

    def initialize(title, artist, album, genre, length)
      @title = title
      @artist = artist
      @album = album
      @genre = genre
      @length = length
    end

  end
end