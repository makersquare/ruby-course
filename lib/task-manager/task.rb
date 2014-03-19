
class TM::Task
	attr_reader :id, :description, :task_id
	attr_accessor :priority, :project_id, :status
	def initialize(project_id, description, priority=3)
		@project_id = project_id
		@description = description
		@priority = priority
		@task_id = self.object_id
		@status = "incomplete"
		@creation_date = Time.now
	end
end
