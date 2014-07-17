class CarStats
  def self.calc_top_color(cars)
    top = Hash.new(0)
    cars.each { |car| top[car.color] += 1}
    top.sort_by{ |c, frequency| frequency }[-1][0]
  end

  def self.calc_bottom_color(cars)
    bottom = Hash.new(0)
    cars.each { |car| bottom[car.color] += 1}
    bottom.sort_by{ |c, frequency| frequency }[0][0]
  end
end

