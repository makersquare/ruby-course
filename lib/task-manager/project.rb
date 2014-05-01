
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
		if newest_first
			retrieve_completed_tasks.sort { |a,b| b.date_created <=> a.date_created }
		else
			retrieve_completed_tasks.sort { |a,b| a.date_created <=> b.date_created }
		end
	end

	def list_completed_tasks_by_date(newest_first: true)
		phrase_description = "History of completed tasks"
		phrase_error = "No tasks have been completed"
		filtered_tasks = retrieve_completed_tasks_by_date

		print_header
		puts "#{phrase_description} for project '#{@name}' with id=#{@id}"	
		if filtered_tasks.size == 0
			puts "[#{phrase_error} for this project]"
		else
			TM::Task.print_header
			filtered_tasks.each {|task| task.print_details }
		end
	end

	def list_incompleted_tasks_by_priority(highest_priority_first: true)
		phrase_description = "Remaining tasks"
		phrase_error = "No remaining tasks"
		filtered_tasks = retrieve_incompleted_tasks_by_priority

		print_header
		puts "#{phrase_description} for project '#{@name}' with id=#{@id}"	
		if filtered_tasks.size == 0
			puts "[#{phrase_error} for this project]"
		else
			TM::Task.print_header
			filtered_tasks.each {|task| task.print_details }
		end
	end


	def retrieve_completed_tasks
		@tasks.select {|x| x.completed}	
	end

	def retrieve_incompleted_tasks_by_priority(highest_priority_first: true)
		if highest_priority_first
			retrieve_incompleted_tasks.sort_by { |a| [a.priority, a.date_created] }
		else
			retrieve_incompleted_tasks.sort_by { |a| [-a.priority, a.date_created] }
		end
	end

	def retrieve_incompleted_tasks
		@tasks.select {|task| not task.completed}
	end

	def print_header
		header_line = "[Project] #{@name} | [ID] #{@id}"
		header_line.length.times { print "-"} ; print "\n"
		puts header_line
		header_line.length.times { print "-"} ; print "\n"
	end

	def print_details
		print_header
		TM::Task.print_header
		puts "  [No tasks exist for this project]\n\n" if @tasks.size == 0
		@tasks.each { |task| task.print_details }
	end

	# to help rspec tests
	def self.reset_class_variables
		@@project_count = 0
	end

end