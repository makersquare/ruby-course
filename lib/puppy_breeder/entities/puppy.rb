module PuppyBreeder
  class Puppy
    attr_reader :breed, :name, :age, :status, :id, :cost 

# Initializes with breed, name, age, status, id.
    def initialize(breed, name, age, status="Available")
      @breed = breed
      @name = name
      @age = age
      @status = status # "Available", "On Hold", "Sold"
      @id = nil
      @cost = 500
    end

# PENDING
    def available?
      @status == "Available"
    end

    def available!
      @status = "Available"
    end

# ON HOLD
    def on_hold?
      @status == "On Hold"
    end

    def on_hold!
      @status = "On Hold"
    end

# SOLD
    def sold?
      @status == "Sold"
    end

    def sold!
      @status = "Sold"
    end
  end
end