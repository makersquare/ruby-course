module Songify
  class Genre
    attr_reader :name, :id

    def initialize(genre)
      @name = genre
      @id = nil
    end
  end
end
