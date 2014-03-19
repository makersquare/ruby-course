
class TM::Project
	attr_reader :name, :tasks
	attr_accessor :project_id

	@@project_id = 0

	def initialize(name)
		@name = name
		@tasks = Array.new(0)
		@@project_id += 1
		@project_id = @@project_id
	end

	def self.project_id
		@@project_id
	end
	
	def add_task(description, priority=3)
		@description = description
		@priority = priority
		@tasks << TM::Task.new(@project_id, description, priority)
	end

	def complete_task(task_id)
		selected = @tasks.select { |x| x.task_id == task_id}
		selected[0].status = "complete"
	end

	def completed_tasks
		completed = @tasks.select {|task| task.status == "complete" }
		completed.sort { |x, y| x.creation_date <=> y.creation_date}
	end

	def incomplete_tasks
		incomplete = @tasks.select {|task| task.status == "incomplete" }
		incomplete.sort {|x, y| x.priority <=> y.priority }
	end
end
