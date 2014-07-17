class CarStats

	def self.calc_top_color cars
		best = Hash.new(0)
		cars.each {|v| best[v.color] +=1} 
		best.max_by{|k,v| v}.first
	end

	def self.calc_bottom_color cars
		best = Hash.new(0)
		cars.each {|v| best[v.color] +=1} 
		best.min_by{|k,v| v}.first
	end
end

# class Car
#	def initialize(color)
#		@color = color
#	end
#end