module Songify
  class Song

    attr_reader :artist, :title, :album, :year_published, :rating, :id, :genre

    def initialize(title: nil, artist: nil, album:nil, year_published: nil, rating: nil, genre: nil)
      @title = title
      @artist = artist
      @album = album
      @year_published = year_published
      @rating = rating
      @id = nil
      @genre = genre
    end

    def correct_info(type, correction)      
      # STAR # There might be a better way to do this correction
      case type
      when "title"
        @title = correction
      when "artist"
        @artist = correction
      when "album"
        @album = correction
      when "year_published"
        @year_published = correction
      when "rating"
        @rating = correction
      when "genre"
        @genre = correction
      end
    end

    def rate(stars)
      @rating = stars
    end

  end
end

