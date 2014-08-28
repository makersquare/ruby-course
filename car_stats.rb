
class CarStats
  def self.calc_top_color(cars)
    car_color_count = {}
    cars.each do |x|
      if car_color_count[x.color] == nil
        car_color_count[x.color] = 1
      else 
        car_color_count[x.color] += 1
      end
    end
    top = car_color_count.max_by {|x,y| y }
    top[0]
  end

  def self.calc_bottom_color(cars)
    car_color_count = {}
    cars.each do |x|
      if car_color_count[x.color] == nil
        car_color_count[x.color] = 1
      else 
        car_color_count[x.color] += 1
      end
    end
    bottom = car_color_count.min_by {|x,y| y }
    bottom[0]
  end

end

