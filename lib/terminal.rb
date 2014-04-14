# 
# Created by Chris Kent
# for MakerSquare 4.13.2014
#
# Terminal.rb
# Purpose: all primary controls for display and changing content
#

require 'colorize'
require_relative './task-manager.rb'

class Terminal


	# get project list
	@list = TM::List.new

	# --------------------------------------- #
	# Define user options
	# --------------------------------------- #

	def self.options
		puts "Available commands are: \n" + 	
		"   help".yellow + " - Show these commands again\n" + 
		"   list".yellow + " - List all projects\n" + 
		"   create NAME".yellow + " - Create a new project with name=NAME\n" + 
		"   show PID".yellow + " - Show remaining tasks for project with id=PID\n" + 
		"   history PID".yellow + " - Show completed tasks for project with id=PID\n" + 
		"   add PID PRIORITY DESC".yellow + " - Add a new task to project with id=PID\n" + 
		"   mark TID".yellow + " - Mark task with id=TID as complete"
	end

	
	# --------------------------------------- #
	# Start the class and add options/text
	# --------------------------------------- #

	def self.start

		# Welcome message and options
		puts "\nWelcome to Project Manager Pro®. What can I do for you today?"
		
		# load options and prompt
		puts self.options
		self.select
	end


	# --------------------------------------- #
	# Retart the class and w/ options/text
	# --------------------------------------- #

	def self.restart

		# Welcome message and options
		puts "What else can I do for you?"
		puts "Type 'help' for a list of commands\n".yellow

		# load options and prompt
		self.select
	end

	
	# --------------------------------------- #
	# Start select prompting and responses
	# --------------------------------------- #

	def self.select
	

		# Set user choice 
		@user_choice = gets.chomp
		
		# Display what user selected/entered
		puts "\n > You entered: " + "#{@user_choice}".red
		puts "-------------------------------------------------\n"	

		# --------------------------------------- #
		# Get response and split for filtering
		# --------------------------------------- #

		choice_array = @user_choice.split 	# Catch and store if user entered multiple items and split it
		
		# -- Note: choice_array usage
		# choice_array[0]  contains the main choice 
		# choice_array[1]  contains second variable (NAME, PID, or TID)
		# choice_array[2]  contains third variable (PRIORITY)
		# (DESC) --> @user_choice.split(' ')[3..-1].join(' ') is used below 

		# --------------------------------------- #
		# Filter what user response is 
		# --------------------------------------- #


		case choice_array[0]


			# --------------------------------------- #
			# Help - display options again
			# --------------------------------------- #

			when 'help'
				Terminal.start

			# --------------------------------------- #	
			# list (all projects)
			# --------------------------------------- #

			when 'list'
				
				# Display project list
              	Terminal.get_projects


			# --------------------------------------- #
			# create (project w/ name)
			# --------------------------------------- #

			when 'create'

				# Check for PID from user choice, if not, throw error
				if choice_array[1]

					@list.create_project(choice_array[1]) # Add project (through project_list)
	              	Terminal.message("Project " + "'#{choice_array[1]}'".red + " was created!") # Display success message	              	
	              	puts "\n"
	              	Terminal.get_projects # Display new project list

	             else
	             	Terminal.message('Please include attributes', 'fail')
					puts "Required attributes are: " + "project name\n".yellow
	             end
				

			# --------------------------------------- #
			# show (remaining tasks w/ project id)
			# --------------------------------------- #
			
			when 'show'
				
				# Check for PID from user choice, if not, throw error
				if choice_array[1]
					Terminal.get_tasks(choice_array[1].to_i, 'incomplete') # Display tasks
				else # display require information
					Terminal.message('Please include attributes', 'fail')
					puts "Required attributes are: " + "project ID\n".yellow
				end



			# --------------------------------------- #
			# history (completed tasks w/ project id)
			# --------------------------------------- #

			when 'history'
				
				# Check for PID from user choice, if not, throw error
				if choice_array[1]
					Terminal.get_tasks(choice_array[1].to_i, 'completed') # Display tasks
				else # display require information
					Terminal.message('Please include attributes', 'fail')
					puts "Required attributes are: " + "project ID\n".yellow
				end


			# --------------------------------------- #
			# add (new task - w/ project id)
			# --------------------------------------- #

			when 'add'
				
				if choice_array[1] && choice_array[2] && choice_array[3]
					
					# get description (remove first three options/array elements)
					desc = @user_choice.split(' ')[3..-1].join(' ')

					add_task = @list.add_task(choice_array[1], choice_array[2], desc) # Add task to project (through project_list)
					
					# Check if project was added successfully
					if add_task != 'error' # Success!					
						Terminal.message("Task added successfully!")
					else # Failed!					
						Terminal.message('That project doesn\'t exist.', 'fail')
					end
				else
					Terminal.message('Please include task attributes', 'fail')
					puts "Required attributes are: " + "project id, priority, and description\n".yellow
				end


			# --------------------------------------- #
			# mark (task complete w/ task id)
			# --------------------------------------- #

			when 'mark'
				
				# Check for PID from user choice, if not, throw error
				if choice_array[1]

					update_task = @list.update_task(choice_array[1], "completed") # Update task (through project_list)

					if update_task != 'error' # Success!					
						Terminal.message('Task has been updated!')
					else # Failed!					
						Terminal.message('That task doesn\'t exist.', 'fail')
					end

				else # display require information
					Terminal.message('Please include attributes', 'fail')
					puts "Required attributes are: " + "project ID\n".yellow
				end

			# --------------------------------------- #
			# Catchall - user entered invalid option
			# --------------------------------------- #

			else
				# Do nothing, except show error
				puts "That was not a valid option. Please try again."
			end


			# --------------------------------------- #
			# End all - restart with another option
			# --------------------------------------- #

			# Spacer
			puts "\n"

			# Restart input command(s)
			Terminal.restart
	end





	# --------------------------------------- #
	# Display message (success and failure)
	# --------------------------------------- #

	def self.message(message,type='success')
		if type == 'success'
			puts " -- Success -- ".yellow + "    #{message}"
			puts "-------------------------------------------------\n"	
		elsif type == 'warning'
			puts " Oops! ".yellow + "   #{message}"
			puts "-------------------------------------------------\n"	
		else
			puts " -- Error -- ".yellow + "     #{message}"
			puts "-------------------------------------------------\n"	
		end
	end


	# --------------------------------------- #
	# Display projects
	# --------------------------------------- #

	def self.get_projects

		# Get task list where status matches 
		project_list = @list.project_list.each{ |project| }

		# Sort by name
		project_list = project_list.sort_by{|x| x.name.downcase}

		# Get results 
		if project_list.empty?
			Terminal.message('No projects were found.', 'warning')
		else
			puts "Showing All Projects (by name)"
			puts "-------------------------------------------------\n"	

			# Display tasks
			project_list.each {|project| puts "	| Name: " + project.name.yellow + "\n ID: #{project.id.to_s}".yellow + "	| Task Count: " + Terminal.get_task_count(project.id.to_i) + "\n	| Created: " + project.create_date.to_s.yellow + "\n-------------------------------------------------"}
		end
	end


	# --------------------------------------- #
	# Display tasks (by status type)
	# --------------------------------------- #

	def self.get_tasks(project_id, type)

		# Get task list where status matches 
		task_list = @list.task_list.select{ |task| task.status == type && task.project_id == project_id.to_i }

		# Sort - by oldest first 
		task_list = task_list.sort_by(&:create_date).reverse # oldest first

		if type == 'incomplete'
			task_list = task_list.sort_by(&:priority).reverse # list highest prority first for incomplete type
		end		

		# Get results 		
		puts "Showing #{type.capitalize} Tasks for Project \"" +  Terminal.get_project_name(project_id)+ "\"\n"
		puts "-------------------------------------------------\n"	
			
		# show results or error message
		if task_list.empty?
			Terminal.message('No tasks were found.', 'warning')
		else
			# Display tasks
			task_list.each {|task| puts "	| Priority: " + task.priority.to_s.yellow + "  	Status: " +  task.status.to_s.red + "\n ID: #{task.id.to_s}".yellow + "	| Description: " + task.desc.to_s.yellow + "\n	| Created: " + task.create_date.to_s.yellow + "\n-------------------------------------------------"}
		end
	end



	# --------------------------------------- #
	# Get project by name
	# --------------------------------------- #

	def self.get_project_name(project_id)
		pname = ""
		@list.project_list.each { |project| pname = "#{project.name}".red }
		return pname
	end



	# --------------------------------------- #
	# Get task count for a project
	# --------------------------------------- #

	def self.get_task_count(project_id)
		list_count = 0
		task_list = @list.task_list.select { |task| task.project_id == project_id.to_i }
		list_count = task_list.count.to_s.red; 
		return list_count
	end

	
end

Terminal.start