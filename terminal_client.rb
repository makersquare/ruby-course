require_relative './lib/task-manager.rb'
require 'pry-debugger'
require 'colorize'

class TM::Terminal

	def self.available_commands
		puts "Available commands : \n"
	puts "
	list - List all projects
	create NAME - Create a new project with name=NAME
	show PID - Show remaining tasks for project with id=PID
	history PID - Show completed tasks for project with ID=PID
	add PID PRIORITY DESC - Add a new task to project with id=PID
	mark TID - Mark task with id=TID as complete
	help - Show these commands again
	quit - GTFO".yellow
	end

	proj = TM::ProjectList.new

	puts "Welcome to Project Manager Pro®. What can I do for you today? \n \n"

	self.available_commands
	@answer = gets.chomp

	while @answer != "quit" #while loop controls all user input/output

		if @answer == "help" #repeats the commands
	  		self.available_commands

  		elsif @answer.split[0] == "create" # creates a new project
  			split_array = @answer.split[1..-1]
  			array = split_array.join(" ")
  			proj.create_project(array)
  			puts "New project #{@answer.split[1]} created. \n".green
			puts "All projects: \n"
  			puts "Project ID 			Project Name"
  			puts "--------------------------------------------"
  			proj.project_list.each do |project|
  				puts "#{project.project_id} 	  			#{project.name}"
  			end
  			puts "\n"

  			available_commands
	   		@answer = gets.chomp

  		elsif @answer == "list"
  			#binding.pry
  			if proj.project_list == []
  				puts "Project ID 			Project Name"
  				puts "--------------------------------------------\n"
  				puts "No projects yet. Type 'create PROJECT NAME' to begin tracking a project. \n\n"
  				available_commands
  				@answer = gets.chomp
  			else
  				
	  			puts "Project ID 			Project Name"
	  			puts "-------------------------------------------- \n \n"
	  			proj.project_list.each do |project|
	  				puts "#{project.project_id} 	  			#{project.name}"
	  			end
	  			available_commands
	  			@answer = gets.chomp
	  		end

  		elsif @answer.split[0] == "add" #add new task add PID PRIORITY DESC
  			#@answer.split[0] = "add"
  			#@answer.split[1] = "PID"
  			#@answer.split[2] = "PRIORITY"
  			#@answer.split[3] = "DESC"
  			pid = @answer.split[1].to_i
  			priority = @answer.split[2].to_i
  			description = @answer.split[3..-1]
  			description = description.join(" ")

  			#selected_proj == the project which will receive the task
  			selected_proj = proj.project_list.find {|project| project.project_id == pid }
  			selected_proj.add_task(description, priority)

  			puts "New task added to project '#{selected_proj.name}'. \n".green

			puts "Project ID #{selected_proj.project_id}: '#{selected_proj.name}'"
			puts "========================================="


			puts "Task ID: #{selected_proj.tasks[-1].task_id}"
			puts "Task Priority: #{selected_proj.tasks[-1].priority}"
			puts "Task Description: '#{selected_proj.tasks[-1].description}'\n\n"
			available_commands
			@answer = gets.chomp

  		elsif @answer.split[0] == "show" #show remaining tasks for project with id=PID
  			proj_id = @answer.split[1].to_i
  			selected_proj = proj.project_list.find { |project| project.project_id == proj_id }
  			puts "Showing project #{proj_id}. \n".green
  			puts "Project ID #{proj_id}: '#{selected_proj.name}'"
			puts "==============================================="
  			selected_proj.incomplete_tasks.each {|task| puts "Task ID: #{task.task_id} '#{task.description}'"}
  			puts " \n "
  			# selected_proj.tasks.each do |task| 
  			# 	puts "Task ID #{task.task_id}: #{task.description}"
  			# end

  			available_commands

  			@answer = gets.chomp

  		elsif @answer.split[0] == "history"
  			proj_id = @answer.split[1].to_i
  			selected_proj = proj.project_list.find { |project| project.project_id == proj_id }
  			puts "Showing completed tasks for project ID #{proj_id}: '#{selected_proj.name}'".green
			puts "==============================================="
  			selected_proj.completed_tasks.each {|task| puts "Task ID: #{task.task_id} '#{task.description}'"}
  			puts " \n "

  			available_commands

  			@answer = gets.chomp

  		elsif @answer.split[0] == "mark"
  			task_id = @answer.split[1].to_i
  			proj.project_list
  			selected_proj = proj.project_list.find { |project| project.tasks.find {|task| task.task_id == task_id}}
  			proj.complete_task(selected_proj.project_id, task_id)
  			puts "Task #{task_id} marked complete. \n \n".green
  			# binding.pry
  			# selected_task = selected_proj.complete_tasks(selected_proj)
  			available_commands
  			@answer = gets.chomp

  		else
	  		puts "Wrong command. Try again. \n \n"
	  		available_commands
	  		@answer = gets.chomp
	  	end
	 end

end