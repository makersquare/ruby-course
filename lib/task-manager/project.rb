
class TM::Project
	attr_reader :name, :tasks
	attr_accessor :project_id
	def initialize(name)
		@name = name
		@project_id = self.object_id
		@tasks = Array.new(0)
	end

	def add_task(description, priority=3)
		@description = description
		@priority = priority
		@tasks << TM::Task.new(@project_id, description, priority)
	end
end
