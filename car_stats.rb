class CarStats
  def self.calc_top_color(car_array)
    color_stats = CarStats.create_hash(car_array) 
    color_stats.key(color_stats.values.max)
  end

  def self.calc_bottom_color(car_array)
    color_stats = CarStats.create_hash(car_array)
    color_stats.key(color_stats.values.min)
  end

  def self.create_hash(car_array)
    color_of_cars = car_array.map { |x| x.color }
    colors = color_of_cars.uniq
    
    color_stats = {}
    
    colors.each do |x| 
      y = color_of_cars.count(x)  
      color_stats[x] = y
    end
    color_stats
  end
end
