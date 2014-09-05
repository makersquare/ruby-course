module PuppyBreeder
  class Breed
    attr_reader :breed
    attr_accessor :price

    def initialize(breed, price)
      @breed = breed
      @price = price
    end

  end
end