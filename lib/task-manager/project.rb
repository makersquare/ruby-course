class FalseClass; def to_i; 0 end end
class TrueClass; def to_i; 1 end end

class TM::Project
	
	# @@project_count = 0
	# @@projects = []

	attr_reader :name, :id, :tasks
	
	def initialize(name="default", id)
		@name = name
		@tasks = []
		# @id = self.class.generate_id
		@id = id
		# self.class.add_project(self)
	end

	def self.add_project(project)
		@@projects << project
	end

	def self.generate_id
		@@project_count += 1
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
			retrieve_completed_tasks.sort_by { |a| -a.date_created.to_i }
		else
			retrieve_completed_tasks.sort_by { |a| a.date_created.to_i  }
		end
	end

	def retrieve_completed_tasks
		@tasks.select {|x| x.completed}	
	end

	def retrieve_incompleted_tasks_by_priority(highest_priority_first: true, overdue_first: true)

		if highest_priority_first
			retrieve_incompleted_tasks.sort_by! { |a| [-a.overdue?.to_i, a.priority, a.date_created] }
			# retrieve_incompleted_tasks.sort_by! { |a| [a.priority] }
		else
			# retrieve_incompleted_tasks.sort_by! { |a| [a.priority] }
			retrieve_incompleted_tasks.sort_by! { |a| [a.overdue?, -a.priority, a.date_created] }
		end
	end

	def retrieve_incompleted_tasks
		@tasks.select {|task| not task.completed}
	end

	##################
	# Printing Methods
	##################

	def print_header(string_ending: "")
		header_line = "[Project] #{@name} | [ID] #{@id}#{string_ending}"
		header_line.length.times { print "="} ; print "\n"
		puts header_line
		header_line.length.times { print "="} ; print "\n"
	end

	def print_details
		print_header
		TM::Task.print_header
		puts "  [No tasks exist for this project]\n\n" if @tasks.size == 0
		@tasks.each { |task| task.print_details }
	end

	def list_tasks(completed: true, newest_first: true, highest_priority_first: true)
		if completed
			phrase_error = "No tasks have been completed"
			filtered_tasks = retrieve_completed_tasks_by_date(newest_first: newest_first)
			header_ending =  "| [HISTORY OF COMPLETED TASKS]"
		else
			phrase_error = "No remaining tasks"
			filtered_tasks = retrieve_incompleted_tasks_by_priority
			header_ending =  "| [SHOWING REMAINING TASKS]"
		end

		print_header(string_ending: header_ending)
		if filtered_tasks.size == 0
			puts "[#{phrase_error} for this project]"
		else
			TM::Task.print_header
			filtered_tasks.each {|task| task.print_details }
		end
	end

	def list_completed_tasks_by_date(newest_first: true)
		list_tasks(completed: true, newest_first: true)
	end

	def list_incompleted_tasks_by_priority(highest_priority_first: true)
		list_tasks(completed: false, highest_priority_first: true)
	end

	# to help rspec tests
	def self.reset_class_variables
		@@project_count = 0
	end

end