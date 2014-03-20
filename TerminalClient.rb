require './lib/task-manager.rb'
require 'io/console'
require 'pry-debugger'

class TerminalClient 
	attr_reader :project, :id
	def initialize
		@projects = TM::ProjectList.new
		help

		while true
			input = gets.chomp
			break if input == 'exit'
			if input == "help"
				help
			elsif input == "list"
				list
			elsif input.include?("create")
				@name = input.gsub(/create /, "").chomp
				create
			elsif input.include?("show")
				@id = input.gsub(/show /,"").chomp
				show
			elsif input.include?("add")
				@task = input.gsub(/add /,"")
				@input_array = @task.split(" ")
				@proj_id = @input_array[0]
				@priority = @input_array[1]
				@description = @input_array[2]
				add_task
			elsif input.include?("history")
				@id = input.gsub(/history /,"").chomp
				history
			elsif input.include?('mark')
				@marked = input.gsub(/mark /,"").chomp
				mark
			else
				puts "That's not a command"
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
		@project = TM::Project.new(@name)
		@projects.add_project(project)
		puts "Your project has been created as: #{@name}"
	end

	def list
		puts "Project List"
		puts "ID 		Project Name"
		@projects.project_list.each{|x| puts "#{x.id}		#{x.name}"}

	end

	def show
		# puts 'show'
		 @projects.tasks_for_project(@id)
		 if @projects.narrowed_again.empty?
		 	puts "There was no incomplete task found."
		 else
		@projects.narrowed_again.each do |x| 
			puts "Project_ID: #{x.project_id}, Priority Number: #{x.priority_number}, Description: #{x.description}"
		end
	end
	end

	def history
		@projects.tasks_for_project_complete(@id)
		if @projects.narrowed_again1.empty?
			puts "There was no complete task found."
		else
			@projects.narrowed_again1.each{|x| puts "Project_ID: #{x.project_id}, Priority Number: #{x.priority_number}, Description: #{x.description}"}
		end
	end


	def add_task
		@tasksomething = TM::Task.new(@description, @priority, @proj_id)
		@project.add_task(@tasksomething)
		puts "Your task with project_id: #{@proj_id} has been added with task id: #{@tasksomething.tid}!"

	end

	def mark 

    result = @projects.mark_task_complete(@marked)
    if result
      puts "Your task with ID: #{@marked} has been marked as complete"
    else
      puts "Task not found"
    end

		# @project.incompleted_tasks_list.each do |x|
		# if x.tid == @marked.to_i
		# #@tasksomething.complete_task
		# @project.complete_task_list(@tasksomething)
		# puts "Your task with ID: #{@tasksomething.tid} has been marked complete."
		# else
		# puts "That ID was not found"
		# end
		# end
	end

	end

	TerminalClient.new

