
class TM::Project
	@@Project_counter = 0
	@@Projects = []

	


	attr_reader :name, :id
	def initialize(name="unnamed")
		@name=name
		@@Project_counter +=1
		@id = @@Project_counter
		@@Projects << self
	end

	def completed_tasks(array)
		return nil if array.nil?

		completed = Array.new
		array.each{|t| completed << t if t.state_complete && t.p_id == @id} 

		completed.sort! {|x,y| x.creation_date <=> y.creation_date }

		return completed

	end

	def incomplete_tasks(array)
		return nil if array.nil?

		incomplete = Array.new
		array.each{|t| incomplete << t if !t.state_complete && t.p_id == @id}

		incomplete.sort! do |x,y|
			comp = x.priority <=> y.priority 
			comp == 0 ? x.creation_date <=> y.creation_date : comp
			
		end

		return incomplete

	end

	def self.list_proyects
		@@Projects.each { |p| puts "Proyect #{id} - #{name}"}
	end

	def self.show_remaining(id)
		
		index = @@Projects.index {|x| x.id == id}
		list = @@Projects[index].incomplete_tasks(TM::Task.list_task)
		puts list
	end



end
