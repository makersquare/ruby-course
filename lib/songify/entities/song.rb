module Songify
  class Song
    attr_reader :title, :artist, :album, :genre_id
    attr_accessor :id

    def initialize(title, artist, album, genre_id=nil)
      @title = title
      @artist = artist
      @album = album
      @genre_id = genre_id
      @id = nil
    end

  end
end