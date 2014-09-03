module Bookly
  class Book
    attr_accessor :id, :name, :published_at

    def initialize(name, published_at=Date.today)
      @name, @published_at = name, published_at
    end
  end
end
