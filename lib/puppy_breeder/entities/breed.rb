#Refer to this class as PuppyBreeder::Breed
require 'pry-byebug'

module PuppyBreeder
  class Breed
    attr_accessor :breed, :price

    def initialize(breed, price)
      @breed = breed
      @price = price
    end

  end
end