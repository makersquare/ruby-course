require_relative 'task-manager.rb'

class TerminalClient

	@@projects = []

	def self.start
		print_welcome_message
		list_commands

		exit_program = false

		while !exit_program do
			print ">> "
			input = gets.chomp

			input_arguments = split_text(input.gsub(/\"/, ''))

			case input_arguments[0]
			when "help"
				list_commands
			when "list" , "ls"
				list_projects
			when "create", "c"
				if check_arguments(input_arguments,1, unlimited: true)
					@@projects << TM::Project.new(input_arguments[1...input_arguments.length].join(" "))
					puts "[Created new project '#{@@projects.last.name} with id=#{@@projects.last.id}]"
				end
			when "show", "s"
				# show(input_arguments[1]) if check_arguments(input_arguments,1)
				list_tasks(input_arguments[1], completed: false) if check_arguments(input_arguments,1)
				# if input_arguments.size == 2
				# end
			when "history", "h"
				# history(input_arguments[1]) if check_arguments(input_arguments,1)
				list_tasks(input_arguments[1], completed: true) if check_arguments(input_arguments,1)
				# if input_arguments.size == 2
				# 	history(input_arguments[1])
				# end
			when "add", "a"
				if check_arguments(input_arguments, 3, unlimited: true)
					task = TM::Task.new(priority: input_arguments[2], description: input_arguments[3...input_arguments.length].join(" "))
					project_id = input_arguments[1]
					add_task_to_project(task, project_id)
					puts "[Added task '#{task.description}' to project id=#{project_id}]"
				end
			when "mark", "m"
				if check_arguments(input_arguments, 1)
					mark_task_complete_with_id(input_arguments[1])
					puts "[Marked task id=#{input_arguments[1]} as complete.]"
				end
			when "exit", "quit", "q"
				exit_program = true
			else
				puts "Command [#{input_arguments[0]}] not recognized."
				puts "Type 'help' for list of commands"
			end
		end
	end

	def self.print_welcome_message
		puts "Welcome to Project Manager Pro®. What can I do for you today?\n\n"
	end

	def self.list_commands
		puts "Available Commands:"
		puts "   help                       Show these commands again"
		puts "   list (ls)                  List all projects"
		puts "   create NAME                Create a new project with name=NAME"
		puts "   show PID                   Show remaining tasks for project with id=PID"
		puts "   history PID                Show completed tasks for project with id=PID"
		puts "   add PID PRIORITY DESC -    Add a new task to project with id=PID"
		puts "   mark TID                   Mark task with id=TID as complete"
		puts "   exit (q)                   quits application"
	end

	def self.check_arguments(input_arguments, expected_num_arguments, unlimited: false)
		if input_arguments.size < expected_num_arguments +1
			puts "Too few arguments for [#{input_arguments[0]}]."
			return false
		end

		unless unlimited
			if input_arguments.size > expected_num_arguments +1
				puts "Too many arguments for [#{input_arguments[0]}]."
				return false
			end
		end
		return true
	end

	def self.add_project(project)
		@@projects << project
	end

	def self.list_projects
		puts "[No projects exist]" if @@projects.size == 0
		@@projects.each do |project|
			header_line = "[Project] #{project.name} | [ID] #{project.id}"
			header_line.length.times { print "-"} ; print "\n"
			puts header_line
			header_line.length.times { print "-"} ; print "\n"
			TM::Task.print_header
			puts "  [No tasks exist for this project]\n\n" if project.tasks.size == 0
			project.tasks.each { |task| task.print_details }
		end

	end

	def self.show(project_id)
		project = get_project_by_id(project_id)
		if project == nil
			puts "Project with id='#{project_id}' not found."
		else
			puts "Remaining tasks for project '#{project.name}' with id=#{project.id}"
			remaining_tasks = project.retrieve_incompleted_tasks_by_priority
			if remaining_tasks.size == 0
				puts "No remaining tasks, all are completed."
			else
				TM::Task.print_header
				remaining_tasks.each {|task| task.print_details }
			end
		end
	end

	def self.history(project_id)
		project = get_project_by_id(project_id)
		if project == nil
			puts "Project with id='#{project_id}' not found."
		else
			puts "History of completed tasks for project '#{project.name}' with id=#{project.id}"
			completed_tasks = project.retrieve_completed_tasks_by_date
			if completed_tasks.size == 0
				puts "[No tasks have been completed for this project]"
			else
				TM::Task.print_header
				completed_tasks.each {|task| task.print_details }
			end
		end
	end

	def self.list_tasks(project_id, completed: true)
		project = get_project_by_id(project_id)
		if project == nil
			puts "Project with id='#{project_id}' not found."
		else
			if completed
				phrase_description = "History of completed tasks"
				phrase_error = "No tasks have been completed"
				filtered_tasks = project.retrieve_completed_tasks_by_date
			else
				phrase_description = "Remaining tasks"
				phrase_error = "No remaining tasks"
				filtered_tasks = project.retrieve_incompleted_tasks_by_priority
			end

			puts "#{phrase_description} for project '#{project.name}' with id=#{project.id}"	
			if filtered_tasks.size == 0
				puts "[#{phrase_error} for this project]"
			else
				TM::Task.print_header
				filtered_tasks.each {|task| task.print_details }
			end
		end
	end

	def self.get_project_by_id(project_id)
		@@projects.each_index do |x|
			return @@projects[x] if @@projects[x].id == project_id.to_i # note the to_i is needed!	
		end
		return nil
	end

	def self.add_task_to_project(task, project_id)
		# puts "test"
		project = get_project_by_id(project_id)
		if project == nil
			puts "Project with id='#{project_id}' not found."
		else
			project.add_task(task)
			puts "Added task [Description: #{task.description} to project #{project.name} with id=#{project.id}"
		end
	end

	def self.mark_task_complete_with_id(task_id)
		task_found = false
		@@projects.each_index do |x|
			@@projects[x].tasks.each_index do |y|
				if @@projects[x].tasks[y].id == task_id.to_i  # note the to_i is needed!
					@@projects[x].tasks[y].mark_completed
					task_found = true
				end
			end
		end
		if task_found == false			
			puts "Task with id='#{task_id}' not found in any of the projects."
		end
	end

	def self.split_text(input)
		new_input = []
		# everything up to first double quote
		# "hello".index('e') --> 1
		# input.scan(\".*\")
		# text.scan(/"([^"]*)"/)

		return input.split
	end



end

# project1 = TM::Project.new("project1")

# puts project1.name

TerminalClient.start
# TerminalClient.add_task_to_project(1, 2)