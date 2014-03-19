
class TM::Project
	@@id = -1
	attr_reader :name, :id
	def initialize (name)
		@name = name
		@id = @@id+=1
		

	end

	
end