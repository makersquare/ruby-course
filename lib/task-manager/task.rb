# 
# Created by Chris Kent
# for MakerSquare 4.13.2014
#
# task.rb 
#

class TM::Task

	attr_reader :id, :desc, :create_date
	attr_accessor :project_id, :priority, :status

	@@count = 0; 

	# Initialize 
	def initialize(project_id, priority=nil, desc)
		@id = @@count += 1
		@project_id = project_id
		@desc = desc
		@priority = priority
		@status = "incomplete"
		@create_date = Time.now
	end
	
end
