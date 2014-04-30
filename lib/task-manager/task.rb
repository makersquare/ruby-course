
class TM::Task
	attr_reader :id, :date_created, :date_completed, :completed
	attr_accessor :name, :project_id, :priority, :description

	@@task_count = 0

	def initialize(name = "default", description: "none", priority: 1)
		@name = name
		@@task_count +=1
		@id = @@task_count
		@project_id = nil
		@description = description
		@priority = priority
		@date_created= Time.now
		@date_completed = nil
		@completed = false
	end

	def mark_completed
		@completed = true
		@date_completed = Time.now
	end

	def mark_incomplete
		@completed = false
		@date_completed = nil
	end

	def print_details
		puts "Task Name: #{@name}"
		puts "Task ID: #{@id}"
		puts "Description: #{@description}"
		puts "Priority: #{@priority}"
		puts "Date Created: #{@date_created}"
		puts "Completed?: #{@completed}"
		puts "Date Completed: #{@date_completed}"
	end	

	# following methods are to assist rspec

	def self.reset_class_variables
		@@task_count = 0
	end

	def set_id(id)
		@id = id
	end

	def set_date_created(time)
		@date_created = time
	end

	def set_priority(num)
		@priority = num
	end

end