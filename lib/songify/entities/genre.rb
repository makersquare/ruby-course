#genre class goes here 

module Songify
  class Genre
    attr_reader :genre
    attr_accessor :id

    def initialize(genre)
      @genre=genre
      @id=nil
    end
  end
end
