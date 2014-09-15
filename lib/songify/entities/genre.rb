
module Songify

  class Genre

    attr_reader :title, :id

    def initialize(genre_title)
      @title = genre_title
      @id=nil
    end

  end

end