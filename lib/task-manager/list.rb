# 
# Created by Chris Kent
# for MakerSquare 4.13.2014
#
# list.rb 
# Purpose: Allows for project creation, task creation, and task updating and storage of project and task lists/data
#

class TM::List
	
	attr_reader :project_list, :task_list

	def initialize
		@project_list = []
		@task_list = []
	end



	# --------------------------------------- #
	# Create project
	# --------------------------------------- #

	def create_project(name)
		project = TM::Project.new(name)
		@project_list << project
	end




	# --------------------------------------- #
	# Add task to project
	# --------------------------------------- #

	def add_task(project_id, priority=nil, desc=nil)
		task = TM::Task.new(project_id.to_i, priority.to_i, desc)
		@task_list << task
	end



	# --------------------------------------- #
	# Update task status
	# --------------------------------------- #
	
	def update_task(task_id, status)
		task = @task_list.find{ |task| task.id == task_id.to_i }
		if task
			task.status = status;
		else
			return "error"
		end
	end


end