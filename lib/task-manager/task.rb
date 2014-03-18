
class TM::Task
	attr_accessor :description, :priority, :status
	attr_reader :project_id, :id

	@@id_counter = 0

	def initialize(project_id, description, priority)
		@project_id = project_id
		@description = description
		@priority = priority
		@id = @@id_counter += 1
		@status = 'incomplete'
	end

	def mark_complete
		if @status == 'incomplete'
			@status = 'complete'
		end
	end
end
