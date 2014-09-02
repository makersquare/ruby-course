#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy
    attr_accessor :name, :breed, :age 
    
    def initialize(name, breed, age)
      @name = name
      @breed = breed
      @age = age
      
      # PuppyBreeder::Breeder.add_inventory(self)
      
    end

    
    # def set_breed_price(breed, price)
    # #this sets the price for each breed
    # end

  end
end