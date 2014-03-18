
class TM::Project
	attr_reader :name, :id, :tasks

	@@id_counter = 0

	def initialize(name)
		@name = name
		@id = @@id_counter += 1
		@tasks = []
	end

	def add_task(description, priority)
		@tasks << TM::Task.new(@id, description, priority)
	end
end
