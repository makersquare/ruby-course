class TM::Task
	attr_reader :project_id, :description, :priority_number, :task_complete, :creation_date
	def initialize (description,priority_number,project_id)
		@description = description
		@priority_number = priority_number
		@project_id = project_id
		@task_complete = false
		@creation_date = Time.now
	end

	def complete_task
		@task_complete = true
		end



end



