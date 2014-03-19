

class TM::Project_list
	@@project_list = []
	def initialize
	
	end

	def self.add_project (project)
	@@project_list.push(project)

	end

	def self.project_list 
		puts "Project List"
		puts "ID 		Project Name"
	@@project_list.each{|x| puts "#{x.id}		#{x.name}"}

	end

end