class TM::Task
	@@tid = -1
	attr_accessor :project_id, :description, :priority_number, :task_complete, :creation_date, :tid
	def initialize (description,priority_number,project_id)
		@description = description
		@priority_number = priority_number
		@project_id = project_id
		@task_complete = false
		@creation_date = Time.now
		@tid = @@tid+=1
	end

	def complete_task
		@task_complete = true
	end



end



