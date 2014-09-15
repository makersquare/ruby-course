module Songify
  class Genre 

    attr_accessor :genre, :id
    def initialize(genre)
      @genre = genre
      @id = nil
    end

  end
end
