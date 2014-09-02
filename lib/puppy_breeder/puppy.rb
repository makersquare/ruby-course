#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy

# Access cost and status. Read breed, name, age, and puppy_id.
    attr_accessor :cost, :sold_status
    attr_reader :breed, :name, :age, :puppy_id

# Counter for setting puppy_id.
    @@puppy_counter = 0 

# Initializes with breed, name, age, sold_status, and puppy_id. 
# sold_status can be "Available", "Sold", or "Pending"
    def initialize(breed, name, age, sold_status="Available")
      @breed = breed
      @name = name
      @age = age
      @sold_status = sold_status
      @@puppy_counter += 1
      @puppy_id = @@puppy_counter
    end

  end
end