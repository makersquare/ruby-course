
class TM::Project
	@@id = -1
	attr_reader :name, :id, :completed_tasks_list, :incompleted_tasks_list
	def initialize (name)
		@name = name
		@id = @@id+=1
		@completed_tasks_list = []
		@incompleted_tasks_list = []
		

	end

	def complete_task_list(task)
		if task.task_complete == true
			@completed_tasks_list.push(task)
		end
			@completed_tasks_list.sort_by{|x| x.creation_date}

	end

	def incomplete_task_list(task)
		if task.task_complete == false
			@incompleted_tasks_list.push(task)
		end
		@incompleted_tasks_list.sort_by{|x| x.priority_number}

	end

end