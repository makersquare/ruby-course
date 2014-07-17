class Car
  attr_reader :color, :wheel_count

  @@car_collection = []
  def initialize(color, wheel_count=4)
    @color = color
    @wheel_count = wheel_count
    @@car_colleciton << color
  end

  def honk
    'meep'
  end
end

class BigRig < Car

	def initialize(color)
		super
		@wheel_count = 18
	end

	def honk
		'BBBBBRRRRRRAAAAAWWWHHHHH'
	end
end

class Motorcycle < Car

	def initialize(color='red')
		super
		@wheel_count = 2
	end



end