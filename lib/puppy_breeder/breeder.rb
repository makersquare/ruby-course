module PuppyBreeder
  class Breeder
  @@puppy_inventory = {}

    def self.add_puppy(name, breed, age)
      @@puppy_inventory[breed] = [name, age]
    end
    
    def self.puppy_inventory
      @@puppy_inventory
    end

  end
end