class Car
  attr_reader :color, :wheel_count

  def initialize(color, wheel_count=4)
    @color = color
    @wheel_count = wheel_count
  end

  def honk
    'meep'
  end
end

class BigRig < Car
  attr_reader :wheel_count
  def initialize(color)
    super
    @wheel_count = 18
  end

  def honk
    "BBBBBRRRRRRAAAAAWWWHHHHH"
  end
end

class Motorcycle < Car
  def initialize
    super("red", 2)
  end
end