class Puppy
  attr_reader :breed, :age, :cost

  def initialize(arg)
    @breed = arg[:breed]
    @age = arg[:age] || 0
    @cost = arg[:cost] || 0
  end

end