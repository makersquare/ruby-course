
class CarStats
  def self.calc_top_color(cars)
    car_colors = cars.map {|car| car.color}
    car_colors.sort_by {|color| car_colors.count(color)}.pop
  end

  def self.calc_bottom_color(cars)
    car_colors = cars.map {|car| car.color}
    car_colors.sort_by {|color| car_colors.count(color)}.shift
  end
end
