#Refer to this class as PuppyBreeder::Puppy
module PuppyBreeder
  class Puppy

    attr_reader :breed, :age, :name
    attr_accessor :status, :id, :cost

    def initialize(name, breed='retriever', age=0, status='available')
      @name = name
      @breed = breed
      @age = age
      @status = status
      (PuppyBreeder::Data.allpuppies ||= []) << self
    end

    
  end
end