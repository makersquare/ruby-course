

class TM::ProjectList
	attr_accessor :project_list
	@tasks = []
	def initialize
	@project_list = []
	end

	def add_project (project)
	@project_list.push(project)

	end

	# def project_list 
	# 	puts "Project List"
	# 	puts "ID 		Project Name"
	# @project_list.each{|x| puts "#{x.id}		#{x.name}"}

	# end

	def project_list_with_id (id)
		narrowed_down = @project_list.find{|x| x.id == id.to_i}
		narrowed_again = narrowed_down.incompleted_tasks_list
		if narrowed_again == nil
			puts "you found me"
		end
		narrowed_again.each{|x| puts "Project_ID: #{x.project_id}, Description: #{x.description}, Priority_Number: #{x.priority_ number}"}
		
	end

end