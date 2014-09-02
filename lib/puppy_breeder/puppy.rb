#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy
    attr_accessor :age_in_days
    attr_reader :name, :breed 

    def initialize(breed: nil,name: nil,age_in_days:nil)
      @breed = breed
      @name = name
      @age_in_days = age_in_days
    end
  end
end