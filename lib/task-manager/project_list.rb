require_relative '../task-manager.rb'

class TM::ProjectList
	attr_reader :help, :list 
	attr_accessor :create_project, :projects, :show_incomplete

	def initialize
		@projects = []
	end

	def create_project(name)
		project = TM::Project.new(name)
		@projects << project
		project
	end

	def add_task(pid, priority, description)
		project = @projects.find { |project| project.id == pid }
		task = project.add_task(priority, description)
	end

	def mark_task_complete(tid)
		project = @projects.each do |project|
			if project.include_task?(tid)
				return project.mark_task_complete(tid)
			end
		end
	end

	def show_incomplete(pid)
		project = @projects.find { |project| project.id == pid }
		project.incomplete_tasks
	end

	def show_complete(pid)
		project = @projects.find { |project| project.id == pid }
		project.complete_tasks
	end
end
