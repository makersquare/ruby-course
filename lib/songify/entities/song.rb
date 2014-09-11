module Songify
  class Song
    attr_reader :title, :artist, :genre
    attr_accessor :id

    def initialize(title, artist, genre)
      @title = title
      @artist = artist
      @genre = genre
      @id = nil
    end
    
  end
end