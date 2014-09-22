module Songify
  class Genre
    attr_accessor :id, :name

    def initialize(name)
      @name = name
      @id = nil
    end

  end
end