
class TM::Task
	attr_reader :id, :description
	attr_accessor :priority
	def initialize(description, priority=3)
		@id = self.object_id
		@description = description
		@priority = priority
	end
end
