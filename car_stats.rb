class CarStats

  def self.cars_to_hash(cars)
    @cars_hash = {}

    cars.each do |x|
      if @cars_hash[x.color]
        @cars_hash[x.color] += 1
      else
        @cars_hash[x.color] = 1
      end
      @cars_hash
    end

  end

  def self.calc_top_color(cars)
    cars_to_hash(cars)
    @cars_hash.max_by { |k, v| v}.first

  end

  def self.calc_bottom_color(cars)
    cars_to_hash(cars)
    @cars_hash.min_by { |k, v| v}.first
  end

end