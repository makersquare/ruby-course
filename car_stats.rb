class CarStats
  
  def self.calc_top_color(cars)
    counts = Hash.new(0)
    cars.each { |car| counts[car.color] += 1 }
    top_color = counts.max_by { |color, count| count }
    top_color[0]
  end

  def self.calc_bottom_color(cars)
    counts = Hash.new(0)
    cars.each { |car| counts[car.color] += 1 }
    top_color = counts.min_by { |color, count| count }
    top_color[0]
  end

end


# Nick's way of doing it:
# cars.inject(Hash.new(0)) { |h, i| h[i]+=1; h } 