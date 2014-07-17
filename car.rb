class Car
  attr_reader :color, :wheel_count

  def initialize(args = {})
    @color = args[:color] || default_color
    @wheel_count = args[:wheel_count] || default_wheel_count
  end

  def default_wheel_count
    @wheel_count = 4
  end

  def honk
    'meep'
  end
end

class BigRig < Car

  def default_wheel_count
    @wheel_count = 18
  end

  def honk
    'BBBBBRRRRRRAAAAAWWWHHHHH'
  end
end

class Motorcycle < Car

  def default_wheel_count
    @wheel_count = 2
  end

  def default_color
    @color = 'red'
  end
end
