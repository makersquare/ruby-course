
class TM::Project
	attr_reader :name, :id
	def initialize(name)
		@name = name
		@id = self.object_id
	end
end
