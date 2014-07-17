# 
# Created by Chris Kent
# for MakerSquare 4.13.2014
#
# project.rb
#

class TM::Project

	attr_reader :id, :name, :create_date

	@@count = 0; 

	# Initialize 
	def initialize(name)
		# instance variables
		@id = @@count += 1
		@name = name
		@create_date = Time.now
	end

end
