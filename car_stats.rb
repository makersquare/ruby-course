class CarStats
  attr_accessor :cars

  def initialize(color)
    @color = color
    @cars = []
  end

  def calc_top_color
    "silver"
  end

  def calc_bottom_color
    "white"
  end
end
