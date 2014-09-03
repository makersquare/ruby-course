#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy
    attr_accessor :name, :breed, :age, :adoption_status

    def initialize(name, breed, age, adoption_status="available")
      @name = name
      @breed = breed
      @age = age
      @adoption_status = @adoption_status
    end

  end
end