module Songify
  class Genre
    attr_reader :genre_name
    attr_accessor :genre_id

    def initialize(genre_name)
      @genre_name = genre_name
      @genre_id = nil
    end

  end
end