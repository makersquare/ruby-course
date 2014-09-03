#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy
    attr_reader :name, :age, :breed
    attr_accessor :status

    def initialize(name, age, breed)
      @name = name
      @age = age
      @breed = breed
      @status = :not_for_sale
    end

    def add(price = nil)
      self.status = :for_sale
      ForSale.add(self, price)
    end 

  end
end