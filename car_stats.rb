class CarStats
  # TODO
  def self.calc_top_color(cars)
    top=Hash.new(0) # Create hash to hold all car colors
    cars.each do |car| # Iterate over each cars key to iterate by 1
      top[car.color] += 1 
    end
    top.sort_by{ |color, freq| freq }.last.first
  end

  def self.calc_bottom_color(cars)
    bottom=Hash.new(0) 
    cars.each do |car|
      bottom[car.color] += 1
    end
    bottom.sort_by{ |color, freq| freq }.first.first
  end
end
