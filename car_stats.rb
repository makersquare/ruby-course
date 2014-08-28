class CarStats
  def initialize(color)
    @color = color
  end

  def self.calc_top_color(cars)
    hash = Hash.new(0)
    cars.each { |car| hash[car.color] += 1 }
    hash.max_by { | color, occurence| occurence }[0]
  end

  def self.calc_bottom_color(cars)
    hash = Hash.new(0)
    cars.each { |car| hash[car.color] += 1 }
    hash.min_by { | color, occurence| occurence }[0]
  end
end
