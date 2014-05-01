
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
		tasks.each { |task| @tasks << task if task.class == TM::Task}
	end

	def get_task_by_id(task_id)
		@tasks.each_index { |x| return @tasks[x] if @tasks[x].id == task_id }
		nil
	end

	def get_task_index_by_id(task_id)
		# use this if you need to modify the actual @tasks array
		@tasks.each_index { |x| return x if @tasks[x].id == task_id }
		nil
	end

	def delete_task_by_id(task_id)
		@tasks.delete_if {|task| task.id == task_id }
	end

	def mark_task_completed_by_id(task_id)
		index = get_task_index_by_id(task_id)
		@tasks[index].mark_completed unless index == nil
	end

	def retrieve_completed_tasks_by_date(newest_first: true)
		filtered_tasks = []

		filtered_tasks = @tasks.select {|task| task.completed }

		if newest_first
			filtered_tasks.sort! { |a,b| b.date_created <=> a.date_created }
		else
			filtered_tasks.sort! { |a,b| a.date_created <=> b.date_created }
		end

		return filtered_tasks
	end

	def retrieve_completed_tasks
		@tasks.select {|x| x.completed}
	end

	def retrieve_incompleted_tasks_by_priority(highest_priority_first: true)
		filtered_tasks = []
		filtered_tasks = @tasks.select {|x| !x.completed}

		if highest_priority_first
			filtered_tasks.sort_by! { |a| [a.priority, a.date_created] }
		else
			filtered_tasks.sort_by! { |a| [-a.priority, a.date_created] }
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