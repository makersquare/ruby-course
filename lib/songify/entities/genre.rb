module Songify
  class Genre
    attr_reader :name, :id

    def initialize(genre,id=nil)
      @name = genre
      @id = id
    end
  end
end
