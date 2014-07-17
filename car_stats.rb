class CarStats


  def self.calc_top_color(cars)

    colors = cars.map {|c| c.color}

    colors.group_by do |color|
      color
    end.values.max_by(&:size).first

  end

  def self.calc_bottom_color(cars)
    colors = cars.map {|c| c.color}

    colors.group_by do |color|
      color
    end.values.min_by(&:size).last

  end

  # TODO
end
