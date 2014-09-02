#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy
    attr_accessor :name, :breed, :age, :puppy_id
    @@counter = 0
    def initialize(name, breed, age)
      @name = name
      @breed = breed
      @age = age
      @puppy_id = @@counter += 1
    end 

  end

  class Puppycontainer
    
    def initialize(puppy)
      @puppy = puppy
      @pound = Hash.new(0)
    end
    
    def add_stats(breed, cost)
      @pound[breed] = {
          :cost => cost,
          :available => []
        }
    end

    def add_pup_pound(puppy)
      @pound[puppy.breed][:available] << puppy
    end
    
    def pound
      @pound
    end

  end
end

