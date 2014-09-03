#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy
    attr_accessor :name, :breed, :age
    def initialize(name, breed, age)
      @name = name
      @breed = breed
      @age = age
    end 

  end

  class Puppycontainer
    @@pound = {}
    
    def self.add_breed(breed, cost=0)
      @@pound[breed] = {
          :cost => cost,
          :available => []
        }
    end

    def self.add_pup_pound(puppy)
      if @@pound[puppy.breed]
        @@pound[puppy.breed][:available] << puppy
      else
        raise "No breed yet"
      end

    end
    
    def self.pound
      @@pound
    end

  end
end

