
class TM::Project
	@@id = -1
	attr_reader :name, :id, :completed_tasks_list, :incompleted_tasks_list
	def initialize (name)
		@name = name
		@id = @@id+=1
		@completed_tasks_list = []
		@incompleted_tasks_list = []
		@tasks = []

	end
	def complete_task_list(task)
		if task.task_complete == true
			@completed_tasks_list.push(task)
			@incompleted_tasks_list.delete(task)
		end
			@completed_tasks_list.sort_by{|x| x.creation_date}

	end


	def add_task(task)
		if task.task_complete == false
			@incompleted_tasks_list.push(task)
		end
		@incompleted_tasks_list.sort_by{|x| x.priority_number}

	end

	 def mark_task_complete(task_id)
	 	binding.pry
	 	task = @incompleted_tasks_list.find{|x| x.tid == task_id.to_i}
	 	task.complete_task

	 # 	@project.incompleted_tasks_list.each do |x|
		# if x.tid == @marked.to_i
		# @tasksomething.complete_task
		# @project.complete_task_list(@tasksomething)
		# puts "Your task with ID: #{@tasksomething.tid} has been marked complete."
		# else
		# puts "That ID was not found"
		# end
		# end

    
  end

  def includes_task?(task_id)
  	 @incompleted_tasks_list.find{|x| x.tid == task_id.to_i}
  end



end