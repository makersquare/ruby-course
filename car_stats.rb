
class CarStats
  def self.calc_top_color(cars)
    car_colors = car_colors_array(cars)
    car_colors.sort_by {|color| car_colors.count(color)}.pop
  end

  def self.car_colors_array(cars)
    cars.map {|car| car.color}
  end

  def self.calc_bottom_color(cars)
    car_colors = car_colors_array(cars)
    car_colors.sort_by {|color| car_colors.count(color)}.shift
  end
end
