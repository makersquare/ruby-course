class CarStats

  def self.calc_top_color(cars)
    count = Hash.new(0)
    cars.each do |x|
      count[x.color] += 1
    end
    count.sort_by {|clr, num| num}.last.first
  end

  def self.calc_bottom_color(cars)
    count = Hash.new(0)
    cars.each do |x|
      count[x.color] += 1
    end
    count.sort_by {|clr, num| num}.first.first
  end
  
end
