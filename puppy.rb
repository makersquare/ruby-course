require "file_requirements.rb"

class Puppy

  attr_reader :breed, :name, :age

  def initialize(args)
    @breed = args[:breed]
    @name = args[:name]
    @age = args[:age]
  end
end