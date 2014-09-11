module Songify
  class Song
    attr_reader :title, :artist, :album, :genre, :length
    attr_accessor :id

    def initialize(title, artist, album, genre, length)
      @title = title
      @artist = artist
      @album = album
      @genre = genre
      @length = length
      @id = nil
    end

  end
end