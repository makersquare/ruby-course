
class TM::Project

	attr_reader :name, :id, :tasks
	
	@@project_count = 0

	def initialize(name="default")
		@name = name
		@@project_count +=1
		@id = @@project_count
		@tasks = []
	end

	def add_task(*tasks)
		#extension -- handle multiple tasks, splat argument
		tasks.each do |task|
			if task.class == TM::Task
				@tasks << task 
				@tasks.last.project_id = @id
			end
		end
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
		return nil if @tasks.size == 0

		task_found = false
		deleted_task = nil

		@tasks.each_index do |x|
			if @tasks[x].id == task_id
				task_found = true
				deleted_task = @tasks[x]
				@tasks.delete_at(x)
			end
		end

		if task_found
			deleted_task
		else
			nil
		end
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

		# use select for a one-liner!! david did this, very simple


		@tasks.each_index do |x|
			if @tasks[x].completed
				filtered_tasks << @tasks[x]
			end
		end

		# can refactor to one-line using sort_by
		if newest_first
			filtered_tasks.sort! { |a,b| b.date_created <=> a.date_created }
		else
			filtered_tasks.sort! { |a,b| a.date_created <=> b.date_created }
		end
		return filtered_tasks
		
	end

	def retrieve_completed_tasks
		filtered_tasks = []
		@tasks.each_index do |x|
			if @tasks[x].completed
				filtered_tasks << @tasks[x]
			end
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
			filtered_tasks.sort! do |a,b|
				comp = a.priority <=> b.priority
				comp.zero? ? a.date_created <=> b.date_created : comp
			end
		else
			filtered_tasks.sort! do |a,b|
				comp = b.priority <=> a.priority
				comp.zero? ? a.date_created <=> b.date_created : comp
			end
		end

		return filtered_tasks		
	end

	def retrieve_incompleted_tasks
		filtered_tasks = []
		@tasks.each_index do |x|
			if @tasks[x].completed == false
				filtered_tasks << @tasks[x]
			end
		end

		return filtered_tasks		
	end

	# to help rspec tests
	def self.reset_class_variables
		@@project_count = 0
	end

end