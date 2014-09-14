module Songify
  class Song

    attr_reader :artist, :title, :album, :year_published, :rating, :id, :genre, :lyrics

    def initialize(title: nil, artist: nil, album:nil, year_published: nil, rating: nil, genre: nil, lyrics: nil)
      @title = title
      @artist = artist
      @album = album
      @year_published = year_published
      @rating = rating
      @id = nil
      @genre = genre
      @lyrics = lyrics
    end

    def correct_info(params)      
      # STAR # There might be a better way to do this correction
      case params.keys
      when [:title]
        @title = params.values.first
      when [:artist]
        @artist = params.values.first
      when [:album]
        @album = params.values.first
      when [:year_published]
        @year_published = params.values.first
      when [:rating]
        @rating = params.values.first
      when [:genre]
        @genre = params.values.first
      when [:lyrics]
        @lyrics = params.values.first  
      end
    end

    def rate(stars)
      @rating = stars
    end

  end
end