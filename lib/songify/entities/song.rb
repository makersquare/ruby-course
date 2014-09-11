
module Songify
  class Song
    attr_reader :title, :artist, :album, :id

    def initialize(title, artist, album)
      @title = title
      @artist = artist
      @album = album
      @id = nil #the reason it's nil is so you can see if the object is saved
      #
    end
  end
end