require './lib/task-manager.rb'
require 'io/console'

class TerminalClient 
	def initialize
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
				@name = input.gsub(/create/, "")
				create
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
		TM::Project_list.add_project(TM::Project.new(@name))
	end

	def list
		TM::Project_list.project_list

	end

	end

	TerminalClient.new