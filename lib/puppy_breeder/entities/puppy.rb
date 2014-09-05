#Refer to this class as PuppyBreeder::Puppy
require 'pry-byebug'

module PuppyBreeder
  class Puppy
    attr_accessor :name, :breed, :age, :adoption_status, :id

    def initialize(name, breed, age, adoption_status=:available, id=nil)
      @name = name
      @breed = breed
      @age = age
      @adoption_status = adoption_status
      @id = id
    end


    def available?
      @adoption_status == :available
    end

    def purchased?
      @adoption_status == :purchased
    end

    def purchased!
      @adoption_status = :purchased
    end

  end
end