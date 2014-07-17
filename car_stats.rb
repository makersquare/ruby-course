class CarStats

  attr_accessor :cars, :pop_color

  def self.calc_top_color cars
    # maps car color(as a symbol) pointing to its frequency in the @cars array
    freq = cars.inject(Hash.new(0)) do |hist, car| 
      hist[car.color] += 1
      hist
    end
    # captures car color with largest value of the k-v pairs
    freq.max_by {|k, v| v}.first
  end

  def self.calc_bottom_color cars
    #does the same as self.calc_top_color, but sorts the ferquency hash by the minimum
    # could DRY up both methods since they differ only in "min_by and max_by"
    freq = cars.inject(Hash.new(0)) do |hist, car| 
      hist[car.color] += 1
      hist
    end
     freq.min_by {|k, v| v}.first
  end
end
