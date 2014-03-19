
class TM::Task
	attr_reader :id, :description, :task_id, :creation_date
	attr_accessor :priority, :project_id, :status

	@@task_id = 0
	def initialize(project_id, description, priority=3)
		@project_id = project_id
		@description = description
		@priority = priority
		@status = "incomplete"
		@creation_date = Time.now
		@@task_id += 1
		@task_id = @@task_id
	end
end
