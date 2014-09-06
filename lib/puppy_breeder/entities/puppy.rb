#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy
    attr_reader :name, :age, :breed 
    attr_accessor :price, :availability, :id

    def initialize(name, age, breed)
      @name = name
      @age = age
      @breed = breed
      @price = nil
      @availability = :for_sale
      @id = nil
    end

    def sold!
      @availability = :sold
    end

  end
end