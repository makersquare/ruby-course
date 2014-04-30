require_relative 'task-manager.rb'

class TerminalClient

	@@projects = []

	def self.start
		print_welcome_message
		list_commands
		input = ""
		while input != "exit" do
			print ">> "
			input = gets.chomp

			input_arguments = split_text(input)

			case input_arguments[0]
				# before (:each) { check_arguments(input_arguments) }
			when "list"
				list_projects
			when "create"
				check_arguments(input_arguments,1)
				if input_arguments.size == 2
					puts "creating..."
					@@projects << TM::Project.new(input_arguments[1])
				end
			when "show"
				check_arguments(input_arguments,1)
				if input_arguments.size == 2
					show(input_arguments[1])
				end
			when "add"
				check_arguments(input_arguments, 3)
				if input_arguments.size == 4
					# task = TM::Task.new(description: "Get shit done!", priority: 3)
					task = TM::Task.new(priority: input_arguments[2], description: input_arguments[3] )
					project_id = input_arguments[1]
					add_task_to_project(task, project_id)
					puts "adding task..."
					# show(input_arguments[1])
				end
			when "mark"
				check_arguments(input_arguments, 1)
				if input_arguments.size == 2
					task_id = input_arguments[1]
					mark_task_complete_with_id(task_id)
					task = TM::Task.new(priority: input_arguments[2], description: input_arguments[3] )
					project_id = input_arguments[1]
					add_task_to_project(task, project_id)
					puts "adding task..."
					# show(input_arguments[1])
				end
			else
				puts "Command [#{input_arguments[0]}] not recognized."
				puts "Type 'help' for list of commands"
			end
		end
		# puts "Welcome to Project Manager Pro®. What can I do for you today?"
	end

	def self.print_welcome_message
		puts "Welcome to Project Manager Pro®. What can I do for you today?\n\n"
	end

	def self.list_commands
		puts "Available Commands:"
		puts "   help            Show these commands again"
		puts "   list            List all projects"
		puts "   create NAME     Create a new project with name=NAME"
		puts "   show PID        Show remaining tasks for project with id=PID"
		puts "   history PID     Show completed tasks for project with id=PID"
		puts "   add PID PRIORITY DESC - Add a new task to project with id=PID"
		puts "   mark TID        Mark task with id=TID as complete"
		puts "   exit            quits application"
	end

	def self.check_arguments(input_arguments, expected_num_arguments)
		if input_arguments.size == 1
			puts "No arguments passed in for '#{input_arguments[0]}'."
			puts "Should be '#{input_arguments[0]} [argument]'"
		end
		if input_arguments.size < expected_num_arguments +1
			puts "Too few arguments for [#{input_arguments[0]}]."
			puts "Should be '#{input_arguments[0]} [argument]*#{expected_num_arguments}'"
		end
		if input_arguments.size > expected_num_arguments +1
			puts "Too many arguments for [#{input_arguments[0]}]."
			puts "Should be '#{input_arguments[0]} [argument]*#{expected_num_arguments}'"
			# puts "Should be 'create [project_name]'"
		end
	end

	def self.list_projects
		puts "Projects List"
		puts "-------------"
		@@projects.each do |project|
			puts "Name: #{project.name}"
			puts "ID: #{project.id}"
			# puts "Description: #{project.description}"
		end
	end

	def self.show(project_id)
		project = get_project_by_id(project_id)
		if project == nil
			puts "Project with id='#{project_id}' not found."
		else
			puts "Remaining tasks for project '#{project.name}' with id=#{project.id}"
			puts project.retrieve_incompleted_tasks_by_priority
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
			# puts project.retrieve_incompleted_tasks_by_priority
		end
	end

	def self.split_text(input)
		new input = []
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