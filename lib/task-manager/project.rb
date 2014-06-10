
class TM::Project
	@@Project_counter = 0

	attr_reader :name, :id
	def initialize(name="unnamed")
		@name=name
		@@Project_counter +=1
		@id = @@Project_counter
	end

	def completed_tasks(array)
		return nil if array.nil?

		completed = Array.new
		array.each{|t| completed << t if t.state_complete}

		completed.sort! {|x,y| x.creation_date <=> y.creation_date }

		return completed

	end

	def incomplete_tasks(array)
		return nil if array.nil?

		incomplete = Array.new
		array.each{|t| incomplete << t if !t.state_complete}

		incomplete.sort! do |x,y|
			comp = x.priority <=> y.priority 
			comp == 0 ? x.creation_date <=> y.creation_date : comp
			
		end

		return incomplete

	end



end
