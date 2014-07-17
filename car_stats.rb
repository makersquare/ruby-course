class CarStats

  attr_reader :color
  def initialize(color)
    @color = color
  end
  def self.calc_top_color(arr)
    colors = {}
    arr.each do |car|
      color = car.color
      if colors[color]
        colors[color] += 1
      else
        colors[color] = 1
      end
    end
    max = colors.max_by {|k,v| v}
    return max[0]
  end
  def self.calc_bottom_color(arr)
    colors = {}
    arr.each do |car|
      color = car.color
      if colors[color]
        colors[color] += 1
      else
        colors[color] = 1
      end
    end
    max = colors.min_by {|k,v| v}
    return max[0]
  end
end
