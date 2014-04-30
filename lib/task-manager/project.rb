
class TM::Project

	attr_reader :name, :id, :tasks
	
	@@project_count = 0

	def initialize(name="default")
		@name = name
		@@project_count +=1
		@id = @@project_count
		@tasks = []
	end

	def add_task(task)
		#extension -- handle multiple tasks, splat argument?
		@tasks << task if task.class == TM::Task
	end

	def get_task_by_id(task_id)
		@tasks.each_index do |x|
			if @tasks[x].id == task_id
				return @tasks[x]
			end
		end
		return nil
	end

	def delete_task_by_id(task_id)

	end

	def mark_task_completed_by_id(task_id)
		task_index = nil

		@tasks.each_index do |x|
			if @tasks[x].id == task_id
				task_index = x
			end
		end
		if task_index == nil 
			nil
		else
			@tasks[task_index].mark_completed
		end
	end

	def retrieve_completed_tasks_by_date(newest_first: true)
		filtered_tasks = []
		@tasks.each_index do |x|
			if @tasks[x].completed
				filtered_tasks << @tasks[x]
			end
		end

		if newest_first
			filtered_tasks.sort! { |a,b| b.date_created <=> a.date_created }
		else
			filtered_tasks.sort! { |a,b| a.date_created <=> b.date_created }
		end
		return filtered_tasks
		
	end

	def retrieve_incompleted_tasks_by_priority(highest_priority_first: true)
		filtered_tasks = []
		@tasks.each_index do |x|
			if @tasks[x].completed == false
				filtered_tasks << @tasks[x]
			end
		end

		if highest_priority_first
			filtered_tasks.sort! { |a,b| a.priority <=> b.priority }
		else
			filtered_tasks.sort! { |a,b| b.priority <=> a.priority }
		end
		return filtered_tasks
		
	end

end