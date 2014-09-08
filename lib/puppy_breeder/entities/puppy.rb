#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy
    attr_reader :id, :name, :breed, :age, :available

    def initialize(name, breed, age)
      @id
      @name = name
      @breed = breed
      @age = age
      @available=true
      #call inventory.add_puppy()
    end
  end
end




