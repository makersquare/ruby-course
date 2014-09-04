#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
    
class Puppy
  
  attr_reader :name, :age, :breed
  
  def initialize(name, age, breed)
    @name = name
    @age = age
    @breed = breed
  end

end

end