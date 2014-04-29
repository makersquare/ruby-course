
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

	def retrieve_completed_tasks_by_date
		filtered_tasks = []
		@tasks.each_index do |x|
			if @tasks[x].completed
				filtered_tasks <<@tasks[x]
			end
		end

		filtered_tasks.sort { |a,b| b.date_created > a.date_created }
		
	end

end
