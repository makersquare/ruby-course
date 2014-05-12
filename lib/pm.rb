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

	def self.list_projects
		puts "[No projects exist]" if TM.db.projects.size == 0
		projects = TM.db.get_all_projects
		projects.each do |project|
			project.print_details
			TM::Task.print_header
			tasks = TM.db.get_tasks_from_project(project.id)
			tasks.each {|task| task.print_details}
		end
	end

	def self.create_project(args)
		return if !check_arguments(args,1, unlimited: true)
		project = TM.db.create_project({name: args[1...args.length].join(" ")})
		puts "[Created new project '#{project.name} with id=#{project.id}]"
	end

	def self.add_task(args)
		return if !check_arguments(args, 3, unlimited: true)
		project_id = args[1].to_i
		priority = args[2]
		description = args[3...args.length].join(" ")
		task = TM.db.create_task({project_id: project_id, priority: priority, description: description})
		puts "[Added task '#{task.description}' to project id=#{project_id}]"
	end

	def self.show_remaining_tasks(args)
		return if !check_arguments(args,1)
		project_id = args[1].to_i
		tasks = TM.db.get_remaining_tasks_from_project(project_id)
		tasks.each {|task| task.print_details}
	end

	def self.show_completed_tasks(args)
		return if !check_arguments(args,1)
		project_id = args[1].to_i
		tasks = TM.db.get_completed_tasks_from_project(project_id)
		tasks.each {|task| task.print_details}
	end

	def self.mark_task_completed(args)
		return if !check_arguments(args, 1)
		id = args[1].to_i
		TM.db.update_task(id, {completed: true})
		puts "[Marked task id=#{id} as complete.]"
	end

end

TerminalClient.start