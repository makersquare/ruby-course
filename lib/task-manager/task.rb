
class TM::Task
	attr_reader :name, :id

	@@task_count = 0

	def initialize(name="default")
		@name = name
		@@task_count +=1
		@id = @@task_count
	end

	
end