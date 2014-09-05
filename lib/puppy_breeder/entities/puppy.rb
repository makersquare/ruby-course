#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy

# Access cost and status. Read breed, name, age, and puppy_id.
    attr_accessor :status
    attr_reader :breed, :name, :age, :id

# Counter for setting puppy_id.
    @@counter = 0 

# Initializes with breed, name, age, sold_status, and puppy_id. 
# sold_status can be "Available", "Sold", or "Pending"
    def initialize(breed, name, age, status="Available")
      @breed = breed
      @name = name
      @age = age
      @status = status
      # @@counter += 1
      # @id = @@counter
    end

# Changes the puppy's status to pending.
    def requested
      @status = "Pending"
    end

# Changes the puppy's status to sold.
    def sold
      @status = "Sold"
    end

  end
end