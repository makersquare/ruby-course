#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy
    attr_accessor :name, :breed, :age

    def initialize(name,breed,age)
      @name = name
      @breed = breed
      @age = age
    end

    def set_price(price)
      @price = price
    end
  end
end