module Songify
  class Song
    attr_reader :title, :artist, :album, :year, :genre_id, :rating, :id

    def initialize(title, artist, album, year=0, genre_id=nil, rating=nil)
      @title = title
      @artist = artist
      @album = album
      @year = year
      @genre_id = genre_id
      @rating = rating
      @id = nil
    end

    def year=(x)
      @year = x
    end

    def rating=(x)
      @rating = x
    end

    def id=(x)
      @id = x
    end

  end
end