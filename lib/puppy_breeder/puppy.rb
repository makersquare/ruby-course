#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy
    attr_accessor :name, :breed, :age 
    @@costs = {}
    def initialize(name, breed, age)
      @name = name
      @breed = breed
      @age = age    
    end
    
    def self.set_breed_price(breed, price)
      @@costs[breed] = price
    end

    def self.costs
      @@costs
    end

  end
end