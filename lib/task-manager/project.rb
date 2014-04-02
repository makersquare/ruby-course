require_relative '../task-manager.rb'

class TM::Project
	attr_accessor :name
	attr_reader :id

	@@id_counter = 0

	def initialize(name)
		@name = name
		@id = @@id_counter += 1
	end

	# def include_task?(tid)
	# 	@tasks.select do |task|
	# 		if task.id == tid
	# 			return true
	# 		else
	# 			return false
	# 		end	
	# 	end
	# end
end
