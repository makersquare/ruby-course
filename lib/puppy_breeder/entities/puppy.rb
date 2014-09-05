#Refer to this class as PuppyBreeder::Puppy
module PuppyPalace
  class Puppy
    attr_accessor :name, :breed, :age

    def initialize(name,breed,age)
      @name = name
      @breed = breed
      @age = age
    end
  end
end