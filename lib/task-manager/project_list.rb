class TM::ProjectList
	attr_reader :project_list

	def initialize
		@project_list = Array.new(0)
	end

	def create_project(name)
		proj =  TM::Project.new(name)
		@project_list << proj
		proj
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

	def complete_task(project_id, task_id)
		match = @project_list.select { |project| project.project_id == project_id}
		match[0].complete_task(task_id)
	end


end