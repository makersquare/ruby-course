class CarStats


def self.calc_top_color(array)
  car_color_count = Hash.new(0)
  array.each do |car|
  car_color_count[car.color] +=1
  end

  calc_color = car_color_count.max_by{|k, v| v}
  calc_color[0]

end

  def self.calc_bottom_color(array)
    car_color_count = Hash.new(0)
    array.each do |car|
    car_color_count[car.color] +=1
  end

  calc_color = car_color_count.min_by{|k, v| v}
  calc_color[0]

end
end
