module Songify
  class Genre

    attr_reader :genre, :id

    def initialize(genre: genre)
      @genre = genre.downcase.capitalize
      @id = nil
    end

  end
end