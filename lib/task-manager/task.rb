require_relative '../task-manager.rb'

class TM::Task
	attr_accessor :complete, :description, :priority
	attr_reader :project_id, :employee_id, :id, :created_at

	@@id_counter = 0

	def initialize(project_id, priority, description)
		@project_id = project_id
		@employee_id = nil
		@description = description
		@priority = priority
		@@id_counter += 1
		@id = @@id_counter
		@complete = false
		@created_at = Time.now
	end
end
