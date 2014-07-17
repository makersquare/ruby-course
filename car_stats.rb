 class CarStats
  
  def self.calc_top_color(cars)
    count = self.color_count(cars)
    count.max_by{|color, count| count}.first
  end

  def self.calc_bottom_color(cars)
    count = self.color_count(cars)
    count.min_by{|color, count| count}.first
  end


  private

  def self.color_count(cars)
    car_count = Hash.new(0)
    cars.each {|car| car_count[car.color]+=1}
    car_count
  end
end
