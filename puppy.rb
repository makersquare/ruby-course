class Puppy
  attr_reader :breed, :age

  def initialize(arg)
    @breed = arg[:breed]
    @age = arg[:age] || 0
  end

end