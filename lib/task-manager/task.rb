
class TM::Task
	attr_accessor :description, :priority, :status
	attr_reader :project_id, :id, :created_at

	@@id_counter = 0

	def initialize(project_id, description, priority)
		@project_id = project_id
		@description = description
		@priority = priority
		@id = @@id_counter += 1
		@status = 'incomplete'
		@created_at = Time.now
	end
end
