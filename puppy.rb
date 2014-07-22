class Puppy
  attr_reader :breed, :age, :cost

  def initialize(arg)
    @breed = arg[:breed]
    @age = arg[:age]
    @cost = arg[:cost]
  end

end