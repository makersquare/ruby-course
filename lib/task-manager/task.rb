
class TM::Task
	attr_reader :name, :id, :project_id, :description, :priority, :date_created, :date_completed, :completed

	@@task_count = 0

	def initialize(name = "default", description: "none")
		@name = name
		@@task_count +=1
		@id = @@task_count
		@project_id = nil
		@description = description
		@priority = 1
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

	# following methods are to assist rspec
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