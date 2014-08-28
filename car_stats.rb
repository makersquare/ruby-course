class CarStats
  attr_accessor :cars_array, :count, :color_count

  def self.calc_top_color(cars_array)
    color_count(cars_array)

    @top_color = @count.max_by { |k, v| v}[0]
  end

  def self.calc_bottom_color(cars_array)
    color_count(cars_array)

    @top_color = @count.min_by { |k, v| v}[0]
  end

  def self.color_count(cars_array)
    colors_array = cars_array.map {|x| x.color }
    @count = Hash.new
    colors_array.each {|x| @count[x] == nil ? @count[x] = 1 : @count[x] += 1}
    @count
  end
end
