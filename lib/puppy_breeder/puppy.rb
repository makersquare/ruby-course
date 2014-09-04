#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy
    attr_reader :id, :name, :breed, :age
    @@counter = 0

    def initialize(name, breed, age)
      @puppy_id = @@counter +=1
      @name = name
      @breed = breed
      @age = age
      #call inventory.add_puppy()
    end
  end
end




