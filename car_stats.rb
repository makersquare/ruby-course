class CarStats
  attr_reader :color

  @@carstats = []



  def self.calc_top_color(car)
    freq = car.map{|x| x.color}.inject(Hash.new(0)){ |h,x| h[x]+=1;h }
    freq.max_by{ |k,v| v }.first
  end

  def self.calc_bottom_color(car)
    freq = car.map{|x| x.color}.inject(Hash.new(0)){ |h,x| h[x]+=1;h }
    freq.min_by{ |k,v| v }.first
  end
end
