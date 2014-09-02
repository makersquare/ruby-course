#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy
    attr_reader :name, :breed, :age
    attr_accessor :price, :status
    def initialize(name, breed, age=0, status='available', price=nil)
      @name = name
      @breed = breed
      @age = age
      @status = status
      @price = price
    end
  end

end


