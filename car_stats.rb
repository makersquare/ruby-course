class CarStats
  # def self.calc_top_color(cars)
  # 	colors = cars.map { |car| car.color }
  # 	histogram = {}
  # 	colors.each do |c|
  # 		if histogram[c].nil?
  # 			histogram[c] = 1
  # 		else
  # 			histogram[c] += 1
  # 		end
  # 	end
  # 	biggest = histogram.max_by { |color, count| count }
  # 	biggest.first
  # end
  # def self.calc_bottom_color(cars)
  # 	colors = cars.map { |car| car.color }
  # 	histogram = {}
  # 	colors.each do |c|
  # 		if histogram[c].nil?
  # 			histogram[c] = 1
  # 		else
  # 			histogram[c] += 1
  # 		end
  # 	end
  # 	biggest = histogram.min_by { |color, count| count }
  # 	biggest.first
  # end  

  def self.calc_top_color cars
  	colors = cars.map { |c| c.color }
  	histogram = colors.inject(Hash.new(0)) do |h,c|
  		h[c] += 1
  		h
  	end
  	histogram.max_by { |c, n| n }.first
  end
  def self.calc_bottom_color cars
  	colors = cars.map { |c| c.color }
  	histogram = colors.inject(Hash.new(0)) do |h,c|
  		h[c] += 1
  		h
  	end
  	histogram.min_by { |c, n| n }.first
  end

  # def self.calc_top_color cars
  # 	top = Hash.new(0) # top = {}
  # 	cars.each do |c|
  # 		top[c.color] += 1
  # 	end
  # 	top.max_by { |k,v| v }.first
  # end
  # def self.calc_bottom_color cars
  # 	top = {}
  # 	cars.each do |c|
  # 		if top.has_key? 

end
