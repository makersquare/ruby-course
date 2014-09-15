module Songify
  class Genre
    attr_reader :genre_name
    attr_accessor :id

    def initialize(genre_name)
      @genre_name = genre_name.downcase
      @id = nil
    end

  end
end