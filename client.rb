require_relative 'lib/task-manager.rb'

class TM::TerminalClient
	def self.start
		@project_list = TM::ProjectList.new
		puts "Welcome to Project Manager Pro®. What can I do for you today?\n\n"
		TM::TerminalClient.help

		choice = gets.chomp.downcase

	  until choice == 'quit' || choice == 'q'
	  	command = choice.split(' ')
	  	
	  	case command[0]
			when "help"
			  TM::TerminalClient.help
			  choice = gets.chomp.downcase
			when "list"
			  TM::TerminalClient.list
			  choice = gets.chomp.downcase
		  when "create"
			  TM::TerminalClient.create(command[1])
			  choice = gets.chomp.downcase
			when "show"
			  TM::TerminalClient.show(command[1].to_i)
			  choice = gets.chomp.downcase
			when "history"
			  TM::TerminalClient.history(command[1].to_i)
			  choice = gets.chomp.downcase
			when "add"
			  TM::TerminalClient.add(command[1].to_i, command[2].to_i, command[3])
			  choice = gets.chomp.downcase
			when "mark"
			  TM::TerminalClient.mark(command[1].to_i)
			  choice = gets.chomp.downcase
			else
			  puts "Invalid command. Please type a command from the following list"
			  TM::TerminalClient.help
			  choice = gets.chomp.downcase
			end
	  end
	end

	def self.help 
		puts "Available Commands:
	  \thelp - Show these commands again
	  \tlist - List all projects
	  \tcreate <NAME> - Create a new project with name=NAME
	  \tshow <PID> - Show remaining tasks for project with id=PID
	  \thistory <PID> - Show completed tasks for project with id=PID
	  \tadd <PID> <PRIORITY> <DESC> - Add a new task to project with id=PID
	  \tmark <TID> - Mark task with id=TID as complete
	  \tquit or q - Quits the program.\n"
	end

	def self.list
		if @project_list.projects.empty?
			puts "Your project list is empty. Type 'help' to find out how to create a project"
		else
			puts "Here is a list of your projects:"
			puts "ID | NAME"
			
			@project_list.projects.each do |project|
				puts " #{project.id} | #{project.name}"
			end
		end
	end

	def self.create(name)
	 	project = @project_list.create_project(name)
		puts "'#{project.name}' was created successfully"
	end 

	def self.add(pid, priority, description)
		task = @project_list.add_task(pid, priority, description)
		puts "'#{task.description}' was successfully added to your project."
	end

	def self.show(pid)
		tasks = @project_list.show_incomplete(pid)
		project = @project_list.projects.find { |project| project.id == pid.to_i }
		puts "Showing incomplete tasks for project '#{project.name}':"
		puts "Priority \tID \tDescription"
		tasks.map do |task|
			puts "\t#{task.priority} \t#{task.id} \t#{task.description}"
		end
	end

	def self.history(pid)
		tasks = @project_list.show_complete(pid)
		project = @project_list.projects.find { |project| project.id == pid.to_i }
		puts "Showing completed tasks for project '#{project.name}':"
		puts "Priority \tID \tDescription"
		tasks.map do |task|
			puts "\t#{task.priority} \t#{task.id} \t#{task.description}"
		end
	end

	def self.mark(tid)
		@project_list.projects.each do |project|
			if project.include_task?(tid)
				@project_list.mark_task_complete(tid)
				puts "The task with id: #{tid}. Has been marked as complete"
			else
				puts "This task is already complete or it does not exist."
			end
		end
	end
end