module Songify
  class Genre
    attr_accessor :genre, :id
    def initialize(genre, id=nil)
      @genre = genre
      @id = id
    end
  end
end
