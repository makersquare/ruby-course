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
  def initialize(color, wheel_count=18)
    super
    @wheel_count = wheel_count
  end

  def honk
    'BBBBBRRRRRRAAAAAWWWHHHHH'
  end
end

class Motorcycle < Car
  def initialize(color='red')
    super(color, 2)
  end

end
