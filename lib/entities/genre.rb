module Songify
  class Genre
    attr_reader :name, :id
    
    # initializes with name variable and a nil id variable
    def initialize(name)
      @name = name
      @id = nil
    end

  end
end