class TM::Task

	@@task_count = 0
	@@tasks = []

	attr_reader :date_created, :date_completed, :completed, :date_due
	attr_accessor :id, :name, :priority, :description

	def initialize(name = "untitled", description: "none", priority: 1)
		@name = name
		@id = self.class.generate_id
		@description = description
		@priority = priority
		@date_created= Time.now
		@date_completed = nil
		@date_due = Time.now + (7*24*60*60) #1 week from now
		# @date_due = Time.now + (30) #1 week from now
		@completed = false
		
		# foreign keys
		@project_id = nil

		self.class.add_task(self)
	end

	def self.add_task(task)
		@@tasks << task
	end

	def self.generate_id
		@@task_count += 1
	end

	def mark_completed
		@completed = true
		@date_completed = Time.now
	end

	def mark_incomplete
		@completed = false
		@date_completed = nil
	end

	def overdue?
		Time.now > @date_due
	end

	def self.print_header
		printf "%-10s %-4s %-12s %-15s %-21s %-15s %-21s %-15s %-21s\n",
		"[Priority]",
		"[ID]",
		"[Name]",
		"[Description]",
		"[Date Created]",
		"[Completed?]",
		"[Date Completed]",
		"[Overdue?]",
		"[Date Due]" 
	end

	def print_details
		printf "%-10s %-4s %-12s %-15s %-21s %-15s %-21s %-15s %-21s\n",
		"#{@priority}",
		"#{@id}",
		"#{@name}",
		"#{@description}",
		"#{@date_created.strftime '%m/%d/%Y %I:%M%p'}",
		"#{@completed ? 'yes' : 'no'}",
		"#{@date_completed == nil ? "" : (@date_completed.strftime '%m/%d/%Y %I:%M%p')}",
		"#{overdue? ? 'yes' : 'no'}",
		"#{@date_due.strftime '%m/%d/%Y %I:%M%p'}"
	end	

	def print_details_old
		puts "  --------------------"
		puts "  Task Name: #{@name}"
		puts "  Task ID: #{@id}"
		puts "  Description: #{@description}"
		puts "  Priority: #{@priority}"
		puts "  Date Created: #{@date_created}"
		puts "  Completed?: #{@completed}"
		puts "  Date Completed: #{@date_completed}"
		puts "  --------------------"
	end	

	# following methods are to assist rspec

	def self.reset_class_variables
		@@task_count = 0
	end

	def set_date_created(time)
		@date_created = time
	end

	def set_priority(num)
		@priority = num
	end

	def set_date_due(date)
		@date_due = date
	end

end