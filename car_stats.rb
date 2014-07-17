class CarStats

  def self.calc_top_color(car_array)
    
    car_array.each_with_object(Hash.new(0)) {|car, color_hash| color_hash[car.color] += 1}.max_by {|k,v| v}[0]

  end

  def self.calc_bottom_color(car_array)
    color_hash = Hash.new(0)

    car_array.each do |x|
      color_hash[x.color] += 1
    end

    color_hash.min_by {|k,v| v}[0]

  end

end
