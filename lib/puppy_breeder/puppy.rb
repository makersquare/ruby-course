#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  
  class Puppy
  
    attr_reader :breed, :name, :age_in_days 

    def initialize(breed: nil,name: nil,age_in_days:nil)
      @breed = BreedFixer.symbol(breed)
      @name = name
      @age_in_days = age_in_days
    end
  
  end

end