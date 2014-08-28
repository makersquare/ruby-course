class CarStats
  def self.calc_top_color(cars)
  colors = {}
  cars.each do |car|
   if colors[car.color] == nil
      colors[car.color] = 1
    else 
      colors[car.color] += 1
    end
  end
     top = colors.max_by {|k,v| v }
     top[0]
end

  def self.calc_bottom_color(cars)
  colors = {}
  cars.each do |car|
   if colors[car.color] == nil
      colors[car.color] = 1
    else 
      colors[car.color] += 1
    end
  end
     bottom = colors.min_by {|k,v| v }
     bottom[0]
  end
end
