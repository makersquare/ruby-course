module Songify
  class Song
    attr_reader :title, :artist, :album
    attr_accessor :id, :genre_id

    def initialize(title, artist, album)
      @title = title
      @artist = artist
      @album = album
      @id = nil
      @genre_id = nil
    end

    def set_genre_id(genre)
      @genre_id = genre.id
    end
  end
end
