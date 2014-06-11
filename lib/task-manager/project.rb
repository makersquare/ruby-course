
class TM::Project
	@@Project_counter = 0
	@@Projects = []

	


	attr_reader :name, :id
	def initialize(name="unnamed")
		@name=name
		@@Project_counter +=1
		@id = @@Project_counter
		@@Projects << self
		# puts 'project created!'
		# @@Projects.each {|p| puts " project #{p.name} id: #{p.id}"}
	end

	def completed_tasks(array)
		return nil if array.nil?

		completed = Array.new
		array.each{|t| completed << t if t.state_complete && t.p_id == @id} 

		completed.sort! {|x,y| x.creation_date <=> y.creation_date }

		return completed

	end

	def incomplete_tasks(array, id=nil)
		return nil if array.nil?

		incomplete = Array.new
		if id.nil?
			array.each{|t| incomplete << t if !t.state_complete}
			# puts "c1"
			# puts incomplete.size
		else
			array.each do |t|
				# puts t.p_id
				# puts id
				# e1 = !t.state_complete
				# e2 = (t.p_id == id)
				# puts "e1: " + e1.to_s
				# puts "e2: " + e2.to_s
				# aux = !t.state_complete && t.p_id == id
				# puts aux
				incomplete << t if !t.state_complete && t.p_id == id
			end
			# puts "c2"
			# puts incomplete.size
		end

		incomplete.sort! do |x,y|
			comp = x.priority <=> y.priority 
			comp == 0 ? x.creation_date <=> y.creation_date : comp
			
		end

		return incomplete

	end

	def self.list_proyects
		@@Projects.each { |p| puts "Proyect id: #{p.id} - Name: #{p.name}"}
	end

	def self.show_remaining(id)
		
		index = @@Projects.index {|x| x.id == id}
		# puts index
		# puts id
		# puts TM::Task.list_task
		list = @@Projects[index].incomplete_tasks(TM::Task.list_task,id)
		list.each {|t| puts "task_id: #{t.id} task_proj: #{t.p_id} creation: #{t.creation_date}"}

	end



end
