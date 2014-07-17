class CarStats
  def self.calc_top_color(input)
    frequency = Hash.new(0)
    input.each {|x| frequency[x.color] +=1}
    top_color = frequency.sort_by {|k,v| v}
    top_color[-1][0]
  end
  def self.calc_bottom_color(input)
    frequency = Hash.new(0)
    input.each {|x| frequency[x.color] +=1}
    bottom_color = frequency.sort_by {|k,v| v}
    bottom_color[0][0]
  end
end
