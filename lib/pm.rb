require_relative 'task-manager.rb'

class TerminalClient

	def self.start
		print_welcome_message
		list_commands

		exit_program = false

		while !exit_program do
			print ">> "
			input = gets.chomp
			args = input.gsub(/\"/, '').split(" ")
			command = args[0]

			case command
			when "help" then list_commands
			when "list" , "ls" then list_projects
			when "create", "c" then create_project(args)
			when "show", "s" then show_remaining_tasks(args)
			when "history", "h" then show_completed_tasks(args)
			when "add", "a" then add_task(args)
			when "mark", "m" then mark_task_completed(args)
			when "exit", "quit", "q" then exit_program = true
			else print_command_error
			end
		end
	end

	def self.print_welcome_message
		puts "Welcome to Project Manager Pro®. What can I do for you today?\n\n"
	end

	def self.print_command_error
		puts "Command not recognized."
		puts "Type 'help' for list of commands"
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

	def self.check_arguments(args, expected_num_arguments, unlimited: false)
		if args.size < expected_num_arguments +1
			puts "Too few arguments for [#{args[0]}]."
			return false
		end

		unless unlimited
			if args.size > expected_num_arguments +1
				puts "Too many arguments for [#{args[0]}]."
				return false
			end
		end
		return true
	end

	def self.add_project(project)
		@@projects << project
	end

	def self.list_projects
		puts "[No projects exist]" if TM.db.projects.size == 0
		TM.db.projects.each do |project_key, project_data|
			project = TM.db.build_project(project_data)
			project.print_details
			TM::Task.print_header
			TM.db.tasks.each do |task_key, task_data|
				task = TM.db.build_task(task_data)
				task.print_details if task.project_id == project.id
			end
		end
	end

	def self.create_project(args)
		if check_arguments(args,1, unlimited: true)
			project = TM.db.create_project({name: args[1...args.length].join(" ")})
			puts "[Created new project '#{project.name} with id=#{project.id}]"
		end
	end

	def self.add_task(args)
		if check_arguments(args, 3, unlimited: true)
			project_id = args[1].to_i
			priority = args[2]
			description = args[3...args.length].join(" ")
			task = TM.db.create_task({project_id: project_id, priority: priority, description: description})
			puts "[Added task '#{task.description}' to project id=#{project_id}]"
		end
	end

	def self.show_remaining_tasks(args)
		list_tasks(args[1].to_i, completed: false) if check_arguments(args,1)
	end

	def self.show_completed_tasks(args)
		list_tasks(args[1].to_i, completed: true) if check_arguments(args,1)
	end

	def self.list_tasks(project_id, completed: true)
		project = TM.db.get_project(project_id)
		if project == nil
			puts "Project with id='#{project_id}' not found."
			return project
		end
		TM.db.tasks.each do |task_key, task_data|
			task = TM.db.build_task(task_data)
			if completed
				task.print_details if task.project_id == project.id && task.completed
			else
				task.print_details if task.project_id == project.id && !task.completed
			end
		end
	end

	def self.get_project_by_id(project_id)
		@@projects.each_index {|x| return @@projects[x] if @@projects[x].id == project_id.to_i }
		return nil
	end

	def self.add_task_to_project(task, project_id)
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

	def self.mark_task_completed(args)
		if check_arguments(args, 1)
			id = args[1].to_i
			TM.db.update_task(id, {completed: true})
			puts "[Marked task id=#{id} as complete.]"
		end
	end

end

TerminalClient.start