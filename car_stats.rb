class CarStats
  def self.calc_top_color(cars)
    top=Hash.new (0) #new hash pairs will by default have 0 as values
    cars.each do |car| #iterate through the cars
      top[car.color]+=1 #set key to equal car color, set value to increase by 1. (0+1)
    end
    top.sort_by{|color, frequency| frequency}.last.first
  # hash is sorted into array by key, value. take last value(greatest), return key
  end
  def self.calc_bottom_color(cars)
    bottom=Hash.new(0)
    cars.each do |car|
      bottom[car.color]+=1
    end
    bottom.sort_by{|color, frequency| frequency}.first.first
  end
end

 