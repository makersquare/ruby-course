require_relative '../task-manager.rb'

class TM::Employee
	attr_reader :name, :id

	@@id_counter = 0

	def initialize(name)
		@name = name
		@id = @@id_counter += 1
	end
end