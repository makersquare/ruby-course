class TM::ProjectList
	attr_reader :project_list

	def initialize
		@project_list = Array.new(0)
	end

	def create_project(name)
		@project_list << TM::Project.new(name)
	end

	def get_project(project_id)
		match = @project_list.select { |project| project.project_id == project_id}
		return match[0]
	end

	def remaining_tasks(project_id)
		match = @project_list.select { |project| project.project_id == project_id}
		return match[0].incomplete_tasks
	end

	def completed_tasks(project_id)
		match = @project_list.select { |project| project.project_id == project_id}
		return match[0].completed_tasks
	end

	def add_task(project_id, description, priority=3)
		match = @project_list.select { |project| project.project_id == project_id}
		match[0].add_task(description, priority=3)
	end
end