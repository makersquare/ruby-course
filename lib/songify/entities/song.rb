
module Songify
  class Song
    attr_reader :title, :artist, :album, :id
    attr_accessor :genre

    def initialize(title, artist, album, genre)
      @title = title
      @artist = artist
      @album = album
      @genre = genre
      @id = nil #the reason it's nil is so you can see if the object is saved
      #
    end
  end
end