require './lib/task-manager.rb'
require 'io/console'
require 'pry-debugger'

class TerminalClient 
	def initialize
		@projects = TM::ProjectList.new
		help

		while true
			input = gets.chomp
			break if input == 'exit'

			if input == "help"
				help
			end

			if input == "list"
				list
			end

			if input.include?("create")
				@name = input.gsub(/create /, "")
				create
			end

			if input.include?("show")
				@id = input.gsub(/show /,"")
				show
			end

			if input.include?("add")
				@task = input.gsub(/add /,"")
				@task.split(" ")
				@proj_id = @task[0]
				@priority = @task[1]
				@description = @task[2]
				add_task
			end
		end
	end


	def help 
		puts "Welcome to Terminal Client. Make a Selection."

		puts "Available Commands:"
		puts "	help - Show these commands again"
		puts " 	list - List all projects"
		puts "	create NAME - Create a new project with name=NAME"
		puts "	show PID - Show remaining tasks for project with id=PID"
		puts "	history PID - Show completed tasks for project with id=PID"
		puts "	add PID PRIORITY DESC - Add a new task to project with id=PID"
		puts "	mark TID - Mark task with id=TID as complete"
		puts "	exit: finish"
	end
	def create 
		@projects.add_project(TM::Project.new(@name))
		puts "Your project has been created as: #{@name}"
	end

	def list
		puts "Project List"
		puts "ID 		Project Name"
		@projects.project_list.each{|x| puts "#{x.id}		#{x.name}"}

	end

	def show
		@projects.project_list_with_id(@id)
	end

	def history

	end

	def add_task
		TM::Task.new(@description, @priority, @proj_id)
	end

	end

	TerminalClient.new