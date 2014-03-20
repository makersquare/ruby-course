require_relative '../task-manager.rb'

class TM::Task
	attr_accessor :description, :priority, :status
	attr_reader :project_id, :id, :created_at

	@@id_counter = 0

	def initialize(project_id, priority, description)
		@project_id = project_id
		@description = description
		@priority = priority
		@@id_counter += 1
		@id = @@id_counter
		@status = 'incomplete'
		@created_at = Time.now
	end
end
