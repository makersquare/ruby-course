module PuppyBreeder
  class Breed
    attr_reader :name
    attr_accessor :price
    
    def initialize(params)
      @name = params[:name]
      @price = params[:price] || 0
    end
  end
end