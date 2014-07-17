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
  def honk
    'BBBBBRRRRRRAAAAAWWWHHHHH'
  end
  def wheel_count
    @wheel_count =18
  end
end
