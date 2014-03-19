class TM::ProjectList
	attr_reader :project_list

	def initialize
		@project_list = Array.new(0)
	end

	def create_project(name)
		@project_list << TM::Project.new(name)
	end
end