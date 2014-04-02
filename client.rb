require_relative 'lib/task-manager.rb'

class TM::TerminalClient
	def self.start
		@db = TM::Database.new
		puts "Welcome to Project Manager Pro®. What can I do for you today?\n\n"
		TM::TerminalClient.help

		command = gets.chomp

	  until command == 'quit' || command == 'q'

			category = command.split(' ')[0].downcase
			action = command.split(' ')[1].downcase
			params = command.split(' ')[2..-1].join(' ')

			if command == 'help'
			  TM::TerminalClient.help
			  command = gets.chomp
			end

	  	case category
	  	when 'project'
	  		case action
				when "list"
				  TM::TerminalClient.project_list
				  command = gets.chomp
			  when "create"
				  TM::TerminalClient.project_create(params)
				  command = gets.chomp
				when "show"
				  TM::TerminalClient.project_show(params)
				  command = gets.chomp
				when "history"
				  TM::TerminalClient.project_history(params)
				  command = gets.chomp
				when "recruit"
					TM::TerminalClient.project_recruit(params)
				  command = gets.chomp
				when "employees"
					TM::TerminalClient.project_employees(params)
				  command = gets.chomp
				end
			when 'task'
				case action
				when "create"
				  TM::TerminalClient.task_create(params)
				  command = gets.chomp
				when "assign"
					TM::TerminalClient.task_assign(params)
				  command = gets.chomp
				when "mark"
				  TM::TerminalClient.task_mark(params)
				  command = gets.chomp
				end
			when 'emp'
				case action
				when "list"
					TM::TerminalClient.employee_list
				  command = gets.chomp
				when "create"
					TM::TerminalClient.employee_create(params)
				  command = gets.chomp
				when "show"
						TM::TerminalClient.employee_show(params)
				  command = gets.chomp
				when "details"
					TM::TerminalClient.employee_details(params)
				  command = gets.chomp
				when "history"
					TM::TerminalClient.employee_history(params)
				  command = gets.chomp
				end
			else
			  puts "Invalid command. Please type a command from the following list"
			  TM::TerminalClient.help
			  choice = gets.chomp
			end
	  end
	end

	def self.help 
		puts "Available Commands:
	  \thelp - Show these commands again
	  \tproject list - List all projects
	  \tproject create <NAME> - Create a new project with name=NAME
	  \tproject show <PID> - Show remaining tasks for project with id=PID
	  \tproject history <PID> - Show completed tasks for project with id=PID
	  \tproject employees <PID> - Show employees participating in this project
	  \tproject recruit <PID> <EID> - Adds employee EID to participate in project PID
	  \ttask create <PID> <PRIORITY> <DESC> - Add a new task to project with id=PID
	  \ttask assign <TID> <EID> - Assign task TID to employee EID
	  \ttask mark <TID> - Mark task with id=TID as complete
	  \temp list - List all employees
	  \temp create <NAME> - Create a new employee
	  \temp show <EID> - Show employee EID and all participating projects
	  \temp details <EID> - Show all remaining tasks assigned to employee EID, along with the project name next to each task
	  \temp history <EID> - Show completed tasks for employee with id=EID
	  \tquit or q - Quits the program.\n"
	end

	def self.project_list
		if @db.projects.empty?
			puts "Your project list is empty. Type 'help' to find out how to create a project"
		else
			puts "Here is a list of your projects:"
			puts "ID | NAME"
			
			@db.projects.each do |key, value|
				puts " #{key} | #{value.name}"
			end
		end
	end

	def self.project_create(params)
		name = params
	 	project = @db.create_project(name)
		puts "'#{project.name}' was created successfully"
	end 

	def self.project_show(params)
		pid = params.to_i
		tasks = @db.project_incomplete_tasks(pid)
		project = @db.get_project(pid)
		puts "Showing incomplete tasks for project '#{project.name}':"
		puts "Priority \tID \tDescription"
		tasks.map do |task|
			puts "\t#{task.priority} \t#{task.id} \t#{task.description}"
		end
	end

	def self.project_history(params)
		pid = params.to_i
		tasks = @db.project_complete_tasks(pid)
		project = @db.get_project(pid)
		puts "Showing completed tasks for project '#{project.name}':"
		puts "Priority \tID \tDescription"
		tasks.map do |task|
			puts "\t#{task.priority} \t#{task.id} \t#{task.description}"
		end
	end

	def self.project_employees(params)
		pid = params.to_i
		employees = @db.get_emp_for_proj(pid)
		project = @db.get_project(pid)
		puts "Showing employees for project '#{project.name}':"
		puts "ID | EMPLOYEE NAME"
		employees.map do |employee|
			puts " #{employee.id} | #{employee.name}"
		end
	end

	def self.project_recruit(params)
		arguments = params.split(' ')
		pid = arguments[0].to_i
		eid = arguments[1].to_i

		project = @db.get_project(pid)
		employee = @db.get_employee(eid)
		membership = @db.recruit(pid, eid)
		puts "Employee '#{employee.name}' with ID of #{eid} has been assigned to Project '#{project.name}' with ID of #{pid}"
	end

	def self.task_create(params)
		arguments = params.split(' ')
		pid = arguments[0].to_i
		priority = arguments[1].to_i
		description = arguments[2..-1].join(' ')

		task = @db.create_task(pid, priority, description)
		puts "'#{task.description}' was successfully added to your project."
	end

	def self.task_assign(params)
		arguments = params.split(' ')
		tid = arguments[0].to_i
		eid = arguments[1].to_i

		task = @db.get_task(tid)
		employee = @db.get_employee(eid)
		@db.assign_task_to_emp(tid, eid)
		puts "Task '#{task.description}' with ID of #{tid} has been assigned to Employee '#{employee.name}' with ID of #{eid}"
	end

	def self.task_mark(params)
		tid = params.to_i

		task = @db.get_task(tid)
		@db.mark_task_complete(tid)
		puts "Task '#{task.description}' with id: #{tid}. Has been marked as complete"
	end

	def self.employee_list
		if @db.employees.empty?
			puts "Your employees list is empty. Type 'help' to find out how to create a employee"
		else
			puts "Here is a list of your employees:"
			puts "ID | NAME"
			
			@db.employees.each do |key, value|
				puts " #{key} | #{value.name}"
			end
		end
	end

	def self.employee_create(params)
		name = params
	 	employee = @db.create_employee(name)
		puts "'#{employee.name}' was created successfully"
	end 

	def self.employee_show(params)
		eid = params.to_i
		projects = @db.get_proj_for_emp(eid)
		employee = @db.get_employee(eid)
		puts "Showing projects for employee '#{employee.name}':"
		puts "ID | PROJECT NAME"
		projects.map do |project|
			puts " #{project.id} | #{project.name}"
		end
	end

	def self.employee_details(params)
		eid = params.to_i
		tasks = @db.emp_incomplete_tasks(eid)
		employee = @db.get_employee(eid)
		puts "Showing incomplete tasks for employee '#{employee.name}':"
		puts "Priority \tID \tDescription"
		tasks.map do |task|
			puts "\t#{task.priority} \t#{task.id} \t#{task.description}"
		end
	end

	def self.employee_history(params)
		eid = params.to_i
		tasks = @db.emp_complete_tasks(eid)
		employee = @db.get_employee(eid)
		puts "Showing completed tasks for employee '#{employee.name}':"
		puts "Priority \tID \tDescription"
		tasks.map do |task|
			puts "\t#{task.priority} \t#{task.id} \t#{task.description}"
		end
	end
end

TM::TerminalClient.start