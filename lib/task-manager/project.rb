

class TM::Project
	@@Project_counter = 0
	@@Projects = []

	


	attr_reader :name, :id
	def initialize(name="unnamed")
		@name=name
		@@Project_counter +=1
		@id = nil
		@@Projects << self
		return self
	end

	def save!(id)
		if @id == nil
			@id = id
			
		end
	end

	def completed_tasks(array)
		return nil if array.nil?

		completed = Array.new
		array.each{|t| completed << t if t.state_complete && t.p_id == @id} 

		completed.sort! {|x,y| x.creation_date <=> y.creation_date }

		return completed

	end

	def self.incomplete_tasks(pending_task)
		return nil if pending_task.nil?

		# incomplete = Array.new

		# if id.nil?
		# 	array.each{|t| incomplete << t if !t.state_complete}
		# 	# puts "c1"
		# 	# puts incomplete.size
		# else
		# 	array.each do |t|
		# 		incomplete << t if !t.state_complete && t.p_id == id
		# 	end
		# end

		pending_task.sort! do |x,y|
			comp = x['priority'] <=> y['priority'] 
			comp == 0 ? x['creation'] <=> y['creation'] : comp
			
		end

		return pending_task

	end

	def self.list_proyects(pending_task)
		pending_task.each { |p| puts "Proyect id: #{p['id']} - Name: #{p['name']}"}
		
	end

	def self.show_remaining(pending_task)
		
		# list = incomplete_tasks(pending_task)
		pending_task.each {|t| puts "task_id: #{t['id']} task_proj: #{t['p_id']} creation: #{t['creation']}"}

	end
end
