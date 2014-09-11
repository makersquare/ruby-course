module Songify
  class Genre
    attr_reader :genre, :id

    def initialize(genre)
      @genre = genre
      @id = nil
    end
  end
end
