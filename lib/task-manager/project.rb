require_relative '../task-manager.rb'

class TM::Project
	attr_reader :name, :id, :tasks

	@@id_counter = 0

	def initialize(name)
		@name = name
		@id = @@id_counter += 1
		@tasks = []
	end

	def add_task(priority, description)
		task = TM::Task.new(@id, priority, description)
		@tasks << task
		task
	end

	def mark_task_complete(task_id)
		@tasks.select do |task|
			if task_id == task.id && task.status == 'incomplete'
				task.status = 'complete'
			end
		end
	end

	def incomplete_tasks
		@tasks.select { |task| task.status == 'incomplete' }.sort_by { |task| [-task.priority, task.created_at] }
	end

	def complete_tasks
		@tasks.select { |task| task.status == 'complete' }.sort_by { |task| task.created_at }
	end

	def include_task?(tid)
		@tasks.select do |task|
			if task.id == tid
				return true
			else
				return false
			end	
		end
	end
end
