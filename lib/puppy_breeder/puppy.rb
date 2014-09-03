#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy

  	attr_reader :name, :breed, :age, :status

  	def initialize(name, breed, age)
  		@name = name
  		@breed = breed
  		@age = age
  	end

  end
end