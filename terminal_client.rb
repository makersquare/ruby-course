require_relative './lib/task-manager.rb'
require 'pry-debugger'

class TM::Terminal

	def self.available_commands
		puts "Available commands : \n
		   new - create new list
		   help - Show these commands again
		   list - List all projects
		   create NAME - Create a new project with name=NAME
		   show PID - Show remaining tasks for project with id=PID
		   add PID PRIORITY DESC - Add a new task to project with id=PID
	  	   mark TID - Mark task with id=TID as complete
	  	   quit - GTFO"
	  	answer = gets.chomp
	end

	puts "Welcome to Project Manager Pro®. What can I do for you today? \n \n"

	self.available_commands

	answer = gets.chomp

	while answer != "quit"

		if answer == "help" #repeats the commands
	  		self.available_commands
	  	end

		if answer == "new" # creates a new project list
	  		proj = TM::ProjectList.new
	  		puts "New project list created.

	  		Available commands:
	  		   create NAME - Create a new project with name=NAME
	  		   list - List all projects
	  		   back - Back to the menu"

	  		answer = gets.chomp
	  	end

  		if answer.split[0] == "create" # creates a new project
  			proj.create_project(answer.split[1])
  			puts "New project #{answer.split[1]} created.

  		Available commands: 
  		  create NAME - Create a new project with name=NAME
  		  show PID - Show remaining tasks for project with id=PID
  		  add PID PRIORITY DESC - Add new task to project with id=PID
  		  mark TID - Mark task with id=TID as complete"
  		  answer = gets.chomp
  		end
	 end

end