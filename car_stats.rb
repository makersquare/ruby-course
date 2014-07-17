class CarStats

  def self.calc_top_color(cars)
    colors = cars.map {|x| x.color }
    freq = colors.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    colors.max_by { |v| freq[v] }
  end

  def self.calc_bottom_color(cars)
    colors = cars.map {|x| x.color }
    freq = colors.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    colors.min_by { |v| freq[v] }
  end



end
