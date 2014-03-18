
class TM::Project
	attr_reader :name, :id, :tasks

	@@id_counter = 0

	def initialize(name)
		@name = name
		@id = @@id_counter += 1
		@tasks = []
	end

	def add_task(description, priority)
		task = TM::Task.new(@id, description, priority)
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
end
