class TM::Employee
	@@employees = []

	attr_reader :id, :name
	def initialize(name) 
		@name = name
		@id = nil
		@@employees << self

		return self
	end

	def save!(id)
		if @id == nil
			@id = id
			
		end
	end

	def self.list(list_emp)
		list_emp.each{|e| puts "ID: #{e['id']} - Name: #{e['name']}"}
	end
end
