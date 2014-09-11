module Songify
  class Song
    attr_reader :title, :artist, :album, :genre
    attr_accessor :id

    def initialize(title, artist, album, genre)
      @title = title
      @artist = artist
      @album = album
      @genre = genre
      @id = nil
    end

  end
end