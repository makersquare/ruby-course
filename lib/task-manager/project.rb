
class TM::Project

	attr_reader :name, :id, :tasks
	
	@@project_count = 0

	def initialize(name="default")
		@name = name
		@@project_count +=1
		@id = @@project_count
		@tasks = []
	end

	def add_task(task)
		@tasks << task if task.class == TM::Task
	end

	def get_task_by_id(id)
		@tasks.each_index do |x|
			if @tasks[x].id == id
				return @tasks[x]
			end
		end
		return nil
	end

end
