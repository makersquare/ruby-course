
class TM::Task
	attr_reader :id, :description
	attr_accessor :priority, :project_id
	def initialize(project_id, description, priority=3)
		@project_id = project_id
		@description = description
		@priority = priority
		@task_id = self.object_id
	end
end
