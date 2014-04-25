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

  def initialize(wheel_count)
    super
    @wheel_count =18
  end


  def honk
    'BBBBBRRRRRRAAAAAWWWHHHHH'
  end
end

class Motorcycle < Car

  def initialize(color)
  super("red")
  @wheel_count = 2
  end
end






















