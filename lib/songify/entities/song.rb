module Songify
  class Song
    attr_reader :title, :artist, :album, :year, :genre, :rating, :reviews

    def initialize(title, artist, album, year=0, genre = nil, rating=nil)
      @title = title
      @artist = artist
      @album = album
      @year = year
      @genre = genre
      @rating = nil
      @reviews = []
    end

    def year=(x)
      @year = x
    end

    def rating=(x)
      @rating = x
    end

    def add_review(review, reviewer_name, publisher)
      @reviews << { 
        :review => review,
        :reviewer_name => reviewer_name,
        :publisher => publisher
      }
    end

  end
end