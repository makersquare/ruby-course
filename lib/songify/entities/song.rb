module Songify
  class Song
    attr_reader :title, :artist, :album
    attr_accessor :id, :genre_id

    def initialize(title, artist, album)
      @title = title
      @artist = artist
      @album = album
      @genre_id = nil
      @id = nil
    end

  end
end